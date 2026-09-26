Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1F6C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xARuo-0000X5-9k; Sat, 26 Sep 2026 08:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xARum-0000Wo-F8
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:54:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xARuk-0005KL-2X
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:54:04 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so13488405e9.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790427240; x=1791032040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RHBK7UD/5iK43ADEj4N7EbCeOEOmexbncRFk4fXLhSQ=;
 b=Mm+sEV9NYFLuL8MJUKomc1us8nBZQ+h/ldQ0duda40kg/vIwric0ThMc4RMmWUalOK
 K3et072RUzBiXFtKEYJnNyjBgn+vnySuzwbEzsN4wEztyEh+Lf+ZFwHw2EuDr5nQjk2Z
 eRImjIEbRX2EiSrM48jJz0vKzk/DLz6PzMv/IPZHwwDoF08pwOQVaSR4OiqJ654Lyeje
 GGocQG7LhzEjU4bt/E6/d6nCm1q4IMmarjVrXeRjQZ2ekMqJvPX3Kioqj3m9gQT+aEc7
 G0sX9SvASfC3zU4q2S0ENrwmk7pnhEl57EweGI4qQO7+pdoVT2cyhJn2/lod5MnL2IGH
 3Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790427240; x=1791032040;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RHBK7UD/5iK43ADEj4N7EbCeOEOmexbncRFk4fXLhSQ=;
 b=x8yJ+c1QEe2yOvhBjPQgpsBUfZn+SOzpsI6ah8YIleutu/N9gFOKctY31RBi7xzr2f
 p6RTprpasKkhkTcOi+0uxtRuDc8PdfqA+Tf/sXDSAPNoelvQ7Vh8x3J/KNiI0oalC2kN
 YYN3K8aZVNq8iZ4Lam3SUp+0AMCvERQiL5NTVhKMHcfDUpFcH6ddeo9BXcqEi/yPYIR6
 3Otsqj2kW2tgPv6QFDb6EePY8/WgomB9dyJITixL7/7uDrCpLD4Qdbu82PiKWY4M+T01
 mlfgszmzDuXwPAjpSZJbFW6jf1pMU5b1hzoBZ/ldPMHdyDU5FfFsFfj05uwTISeNkpIx
 uRMQ==
X-Gm-Message-State: AFuF++lnuWaBspkqLnr0pGkkiMDIOaH7epeuHc36V4XdlSPLI3i+1S9O
 cbCmiaplaH2+HIl44sdAhNkyQmTnG0RcXzxxLfKmhRr+fGKk4kum3xOYYtKSyw==
X-Gm-Gg: AYBFou29r0DWA7Ds0otLjnpAR83iXuNFXow/+kZ1G+77CnlP5ATbKOCkRqq0gclioSc
 UyH+nY/8PVWuux0CnUxPvhF8cwsdUxrXvouwOxMwR1z6YQMh+hDbpPjN43xLhg8v/FTI1bin69S
 wbazeSnT7x6u2dTwaCyLYrdshltEOpVKpU4rXkcGA0ARYjgKzWYHmb+HLyMHWKMo94rtQ3p56ZK
 npa1ytI2lPKE8zpNwSvYk/rfZrZBxUauBTXpUeaC2Yc6zZgqXAjr250xRbJNALGVjgach6fHgYe
 T+K/T8fu1QZx6HC56rvRyma+y5h0SXB4+7nyMy7USHAiTgBb0ewfYf5CttYj71N8l4CpKtfh167
 BYAJF45BBGYomPJbk7Xbzr9e2EpLpbTeiY3NgjtmdyOaQH82EhxUHSvKCktqlb3RD0eEyCgWCm6
 FkWh/9aSxgzy1HMCsVltGllz230AJgr/3dAEQViCd0wkL9B3paRtLOouXrotQyh2C66JxW+P5TP
 dfix5gcAvi4HfdaojsrAfSAOsBQvti8bJTa3ZXsobwlijo6CqUH8vswQppRsTBF+No1FikwfvZ0
 nGD4gEgwVZUqYkZqQOw=
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-49fe6707bb7mr164499025e9.30.1790427239748; 
 Sat, 26 Sep 2026 05:53:59 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-23c9-7800-d99b-d42d-2461-dbe0.310.pool.telefonica.de.
 [2a02:3100:23c9:7800:d99b:d42d:2461:dbe0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff044406dsm154084065e9.1.2026.09.26.05.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 05:53:59 -0700 (PDT)
Date: Sat, 26 Sep 2026 12:53:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Christian Speich <c.speich@avm.de>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/7=5D_hw/sd/sd=3A_Use_mu?=
 =?US-ASCII?Q?lti-byte/block_writes_for_block_path?=
In-Reply-To: <20260417-sdcard-performance-b4-v4-3-119e66be10c2@avm.de>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-3-119e66be10c2@avm.de>
Message-ID: <9AB1E142-6957-496F-881A-DC20C7A9AEB4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 17=2E April 2026 09:51:36 UTC schrieb Christian Speich <c=2Espeich@avm=
=2Ede>:
>When writing/reading blocks via WRITE/READ_MULTIPLE_BLOCK we try to
>directly pass this request down to the block layer=2E This can only be do=
ne
>for properly sized and aligned accesses, other access still use a bounce
>buffer but still benefit from copying as much data in one memcpy as
>possible=2E

I really like the whole series since it provides a huge performance boost =
for the SDHCI subsystem=2E When performing a package upgrade inside a Linux=
 guest the stalls when Linux flushes its buffers are essentially gone=2E It=
 would be really nice if the series made it into the upcoming QEMU release=
=2E Some comments below=2E I could send an updated version of this series i=
f needed=2E

>
>RPMB is limited to the slow path using a bounce buffer=2E
>
>Signed-off-by: Christian Speich <c=2Espeich@avm=2Ede>
>---
> hw/sd/sd=2Ec | 228 ++++++++++++++++++++++++++++++++++++++++++++++-------=
--------
> 1 file changed, 172 insertions(+), 56 deletions(-)
>
>diff --git a/hw/sd/sd=2Ec b/hw/sd/sd=2Ec
>index 2c81776df316feda75f97e15cc9bbd1538f1a21c=2E=2Eb27fed2e563e5971dd327=
87498eb8abed9ffe9be 100644
>--- a/hw/sd/sd=2Ec
>+++ b/hw/sd/sd=2Ec
>@@ -1112,24 +1112,36 @@ static const VMStateDescription sd_vmstate =3D {
>     },
> };
>=20
>-static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>+static void sd_blk_read(SDState *sd, void* buf, uint64_t addr,
>+                        uint32_t len)
> {
>     trace_sdcard_read_block(addr, len);
>     addr +=3D sd_part_offset(sd);
>-    if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
>+    if (!sd->blk || blk_pread(sd->blk, addr, len, buf, 0) < 0) {
>         fprintf(stderr, "sd_blk_read: read error on host side\n");
>     }
> }
>=20
>-static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>+static void sd_blk_read_bounce_buffer(SDState *sd, uint64_t addr, uint32=
_t len)
>+{
>+    sd_blk_read(sd, sd->data, addr, len);
>+}

For simplicity and since there are already cases where we pass multiple sd=
->foo to sd_blk_* I wouldn't introduce the *_bounce_buffer wrappers and ins=
tead use sd_blk_* directly with the additional argument=2E For easier revie=
w this should be a separate patch=2E

>+
>+static void sd_blk_write(SDState *sd, const void *buf, uint64_t addr,
>+                         uint32_t len)
> {
>     trace_sdcard_write_block(addr, len);
>     addr +=3D sd_part_offset(sd);
>-    if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
>+    if (!sd->blk || blk_pwrite(sd->blk, addr, len, buf, 0) < 0) {
>         fprintf(stderr, "sd_blk_write: write error on host side\n");
>     }
> }
>=20
>+static void sd_blk_write_bounce_buffer(SDState *sd, uint64_t addr, uint3=
2_t len)
>+{
>+    sd_blk_write(sd, sd->data, addr, len);
>+}
>+
> static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
>                            unsigned int num_blocks, uint8_t *mac)
> {
>@@ -1363,7 +1375,7 @@ static void sd_erase(SDState *sd)
>                 continue;
>             }
>         }
>-        sd_blk_write(sd, erase_addr, erase_len);
>+        sd_blk_write_bounce_buffer(sd, erase_addr, erase_len);
>     }
> }
>=20
>@@ -1984,7 +1996,7 @@ static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDSta=
te *sd, SDRequest req)
>         return sd_r1;
>     }
>=20
>-    sd_blk_read(sd, addr, sd->blk_len);
>+    sd_blk_read_bounce_buffer(sd, addr, sd->blk_len);
>     return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
> }
>=20
>@@ -2673,7 +2685,7 @@ static size_t sd_write_data(SDState *sd, const void=
 *buf, size_t length)
>         if (sd_generic_write_data(sd, buf, &length)) {
>             /* TODO: Check CRC before committing */
>             sd->state =3D sd_programming_state;
>-            sd_blk_write(sd, sd->data_start, sd->data_offset);
>+            sd_blk_write_bounce_buffer(sd, sd->data_start, sd->data_offs=
et);
>             sd->blk_written ++;
>             sd->csd[14] |=3D 0x40;
>             /* Bzzzzzzztt =2E=2E=2E=2E Operation complete=2E  */
>@@ -2682,44 +2694,85 @@ static size_t sd_write_data(SDState *sd, const vo=
id *buf, size_t length)
>         break;
>=20
>     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
>-        /*
>-         * Only read one byte at a time=2E We will be called again with =
the
>-         * remaining=2E
>-         */
>-        length =3D 1;
>-
>-        if (sd->data_offset =3D=3D 0) {
>-            /* Start of the block - let's check the address is valid */
>-            if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
>-                                  sd->data_start, sd->blk_len)) {
>-                break;
>+        if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
>+                            sd->data_start + sd->data_offset, length)) {
>+            /* Limit writing data to our device size */
>+            length =3D sd->size - sd->data_start - sd->data_offset;
>+
>+            /* We've read past the end, return a dummy write=2E */
>+            if (length =3D=3D 0) {
>+                return 1;
>             }
>-            if (sd->size <=3D SDSC_MAX_CAPACITY) {
>-                if (sd_wp_addr(sd, sd->data_start)) {
>+        }
>+
>+        if (sd->size <=3D SDSC_MAX_CAPACITY) {
>+            uint64_t start =3D sd->data_start + sd->data_offset;
>+
>+            /*
>+             * Check if any covered address violates WP=2E If so, limit =
our write
>+             * up to the allowed address=2E
>+             */
>+            for (uint64_t addr =3D start; addr < start + length;
>+                 addr =3D ROUND_UP(addr + 1, WPGROUP_SIZE)) {
>+                if (sd_wp_addr(sd, addr)) {
>                     sd->card_status |=3D WP_VIOLATION;
>+
>+                    length =3D addr - start - 1;
>                     break;
>                 }
>             }
>         }
>-        sd->data[sd->data_offset++] =3D value[0];
>-        if (sd->data_offset >=3D sd->blk_len) {
>-            /* TODO: Check CRC before committing */
>-            sd->state =3D sd_programming_state;
>-            partition_access =3D sd->ext_csd[EXT_CSD_PART_CONFIG]
>-                    & EXT_CSD_PART_CONFIG_ACC_MASK;
>-            if (partition_access =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
>-                emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset)=
;
>-            } else {
>-                sd_blk_write(sd, sd->data_start, sd->data_offset);
>+
>+        partition_access =3D sd->ext_csd[EXT_CSD_PART_CONFIG]
>+                            & EXT_CSD_PART_CONFIG_ACC_MASK;
>+
>+        /* Partial write or RPMB (single block only for now) */
>+        if (sd->data_offset > 0
>+            || partition_access =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
>+            length =3D MIN(sd->blk_len - sd->data_offset, length);

Similar to the read case I'd add a

            if (sd->multi_blk_cnt > 0) {
                length =3D MIN(length, sd->multi_blk_cnt * sd->blk_len);
            }

here to prevent `sd->multi_blk_cnt -=3D length / sd->blk_len;` down below =
from underflowing=2E

>+
>+            memcpy(sd->data + sd->data_offset, buf, length);
>+            sd->data_offset +=3D length;
>+
>+            if (sd->data_offset >=3D sd->blk_len) {
>+                sd->state =3D sd_programming_state;
>+                if (partition_access =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB=
) {
>+                    emmc_rpmb_blk_write(sd, sd->data_start, sd->data_off=
set);
>+                } else {
>+                    sd_blk_write_bounce_buffer(sd, sd->data_start,
>+                                               sd->data_offset);
>+                }
>+                sd->blk_written++;
>+                sd->data_start +=3D sd->blk_len;
>+                sd->data_offset =3D 0;
>+                sd->csd[14] |=3D 0x40;
>+
>+                /* Bzzzzzzztt =2E=2E=2E=2E Operation complete=2E  */
>+                if (sd->multi_blk_cnt !=3D 0) {
>+                    if (--sd->multi_blk_cnt =3D=3D 0) {
>+                        /* Stop! */
>+                        sd->state =3D sd_transfer_state;
>+                        break;
>+                    }
>+                }
>+
>+                sd->state =3D sd_receivingdata_state;
>             }
>-            sd->blk_written++;
>-            sd->data_start +=3D sd->blk_len;
>-            sd->data_offset =3D 0;
>+        }
>+        /* Try to write multiple of block sizes */
>+        else if (length >=3D sd->blk_len) {
>+            length =3D QEMU_ALIGN_DOWN(length, sd->blk_len);
>+
>+            sd->state =3D sd_programming_state;
>+            sd_blk_write(sd, buf, sd->data_start, length);
>+            sd->blk_written +=3D length / sd->blk_len;
>+            sd->data_start +=3D length;
>             sd->csd[14] |=3D 0x40;
>=20
>-            /* Bzzzzzzztt =2E=2E=2E=2E Operation complete=2E  */
>             if (sd->multi_blk_cnt !=3D 0) {
>-                if (--sd->multi_blk_cnt =3D=3D 0) {
>+                sd->multi_blk_cnt -=3D length / sd->blk_len;
>+
>+                if (sd->multi_blk_cnt =3D=3D 0) {
>                     /* Stop! */
>                     sd->state =3D sd_transfer_state;
>                     break;
>@@ -2728,6 +2781,12 @@ static size_t sd_write_data(SDState *sd, const voi=
d *buf, size_t length)
>=20
>             sd->state =3D sd_receivingdata_state;
>         }


>+        /* Partial write */
>+        else if (length > 0) {
>+            memcpy(sd->data, buf, length);
>+            sd->data_offset =3D length;
>+        }
>+

It should be possible to fold this case into the if statement=2E Same for =
the read operation below=2E

Best regards,
Bernhard

>         break;
>=20
>     case 26:  /* CMD26:  PROGRAM_CID */
>@@ -2798,7 +2857,6 @@ static size_t sd_read_data(SDState *sd, void *buf, =
size_t length)
>     const uint8_t dummy_byte =3D 0x00;
>     unsigned int partition_access;
>     uint32_t io_len;
>-    uint8_t *value =3D buf;
>=20
>     if (!sd->blk || !blk_is_inserted(sd->blk)) {
>         memset(buf, dummy_byte, length);
>@@ -2838,36 +2896,94 @@ static size_t sd_read_data(SDState *sd, void *buf=
, size_t length)
>         break;
>=20
>     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
>+        if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
>+                              sd->data_start + sd->data_offset, length))=
 {
>+            /* Limit reading data to our device size */
>+            length =3D sd->size - sd->data_start - sd->data_offset;
>+
>+            /* We read past the end, return a dummy read=2E */
>+            if (length =3D=3D 0) {
>+                memset(buf, dummy_byte, 1);
>+                return 1;
>+            }
>+        }
>+
>+        partition_access =3D sd->ext_csd[EXT_CSD_PART_CONFIG]
>+                & EXT_CSD_PART_CONFIG_ACC_MASK;
>+
>+        /* We have a partially read block=2E */
>+        if (sd->data_offset > 0) {
>+            length =3D MIN(sd->data_size - sd->data_offset, length);
>+
>+            memcpy(buf, sd->data + sd->data_offset, length);
>+
>+            sd->data_offset +=3D length;
>+
>+            /* Partial read is complete, clear state=2E */
>+            if (sd->data_offset >=3D sd->data_size) {
>+                sd->data_start +=3D io_len;
>+                sd->data_size =3D 0;
>+                sd->data_offset =3D 0;
>+
>+                if (sd->multi_blk_cnt !=3D 0) {
>+                    if (--sd->multi_blk_cnt =3D=3D 0) {
>+                        sd->state =3D sd_transfer_state;
>+                    }
>+                }
>+            }
>+        }
>         /*
>-         * We will only read one byte at a time=2E We will be called aga=
in with
>-         * the remaining buffer=2E
>+         * Try to read multiples of the block size directly bypassing th=
e local
>+         * bounce buffer=2E
>+         * Not for RPMB=2E
>          */
>-        length =3D 1;
>+        else if (length >=3D io_len
>+                 && partition_access !=3D EXT_CSD_PART_CONFIG_ACC_RPMB) =
{
>+            length =3D QEMU_ALIGN_DOWN(length, io_len);
>=20
>-        if (sd->data_offset =3D=3D 0) {
>-            if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
>-                                  sd->data_start, io_len)) {
>-                return dummy_byte;
>+            /* For limited reads, only read the requested block count=2E=
 */
>+            if (sd->multi_blk_cnt !=3D 0) {
>+                length =3D MIN(length, sd->multi_blk_cnt * io_len);
>             }
>-            partition_access =3D sd->ext_csd[EXT_CSD_PART_CONFIG]
>-                    & EXT_CSD_PART_CONFIG_ACC_MASK;
>+
>+            sd_blk_read(sd, buf, sd->data_start, length);
>+
>+            sd->data_start +=3D length;
>+
>+            if (sd->multi_blk_cnt !=3D 0) {
>+                sd->multi_blk_cnt -=3D length / io_len;
>+
>+                if (sd->multi_blk_cnt =3D=3D 0) {
>+                    sd->state =3D sd_transfer_state;
>+                }
>+            }
>+        }
>+        /* Read partial at the end or sinlge-block RPMB */
>+        else if (length > 0) {
>+            length =3D MIN(length, io_len);
>+
>+            /* Fill the buffer */
>             if (partition_access =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
>                 emmc_rpmb_blk_read(sd, sd->data_start, io_len);
>             } else {
>-                sd_blk_read(sd, sd->data_start, io_len);
>+                sd_blk_read_bounce_buffer(sd, sd->data_start, io_len);
>             }
>-        }
>-        *value =3D sd->data[sd->data_offset++];
>=20
>-        if (sd->data_offset >=3D io_len) {
>-            sd->data_start +=3D io_len;
>-            sd->data_offset =3D 0;
>+            memcpy(buf, sd->data, length);
>=20
>-            if (sd->multi_blk_cnt !=3D 0) {
>-                if (--sd->multi_blk_cnt =3D=3D 0) {
>-                    /* Stop! */
>-                    sd->state =3D sd_transfer_state;
>-                    break;
>+            sd->data_size =3D io_len;
>+            sd->data_offset =3D length;
>+
>+            if (sd->data_offset >=3D io_len) {
>+                sd->data_start +=3D io_len;
>+                sd->data_offset =3D 0;
>+
>+                if (sd->multi_blk_cnt !=3D 0) {
>+                    if (--sd->multi_blk_cnt =3D=3D 0) {
>+                        /* Stop! */
>+                        sd->state =3D sd_transfer_state;
>+                        break;
>+                    }
>                 }
>             }
>         }
>

