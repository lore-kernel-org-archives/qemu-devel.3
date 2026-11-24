Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F4606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZtMPF0t+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DAC9gJxl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzeb-0000Uq-QN; Tue, 24 Nov 2026 18:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeJ-0000ED-6a
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeG-0004x2-CF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:06 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb8HP030759
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kMormZggJ4aPmuYWFqzzUvgyUjhm8iavim+c0g9rmPM=; b=ZtMPF0t+sb+koFrF
 RFy8j7BYoSYx/zF5tQoH7hwml8z2IHeq4HBenblsCFyCmmKIRyPa1Bp2pDrAe1nr
 20sHVIQgmZhrXZ3zq5Qm1W94MC/diGyxJkKbroe79FpLiMUYlFLEFRW/H8Xeicfv
 /KOmaZ/vrtRg6hOPx2zf43QYzQ2/6w7NSmLDuhD6reW/rR9ha108Ka/qlUB8MsGM
 QQMYllL0Fxhshtsmm0phQxZkdrD7JkEYxAFsKlZhorQQgSxnOLEmjR3vTdhwhJdV
 IWX+U7O0+zEFn+dE3ITdLecIpZvVO8wSiZ3UKD7Y04xSrNnToxt/TVEweK6emBtJ
 3F9GaA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7tpgn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94967c6d4f4so546882385a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561803; x=1796166603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kMormZggJ4aPmuYWFqzzUvgyUjhm8iavim+c0g9rmPM=;
 b=DAC9gJxlj+25w5lQyUvttDocpD+QtmeQ7A56Rr3q0LM9t/Rlq8vLFRrxPK8sxOPLR+
 ZnRWUeOdlEKEi9wM+R+llpsVmJYHL+IXkbqT7cBEKj4ryjrIEtp5vYi5DB8BpnqB2JIe
 bYYw9in4CYgwsoyhAw3UTwPtOh4+cAOQJHvFpjPFeUxTmvMV8WwPkqd7BSmS9JLF7sq3
 9nQqUEZWvLcHP7+rySFxVqKbHPcvoBYoKlIVQhjdymaqeEfk6FUzzHD2nG7rVauTSyLy
 XfvCSuLojpmOHosa3hSUY/s/m3uKTQvT6wRfGUJEttxRNVLaWII1jiT3cBLAGqIjqPbT
 /KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561803; x=1796166603;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kMormZggJ4aPmuYWFqzzUvgyUjhm8iavim+c0g9rmPM=;
 b=Mcv0fAOH83TSlt+xQT1PZqfYmT7vH3FaCsniiO575YwK+ifD5vJurcyoiMiFyB5wAm
 P5vlXjgiIN8wvxajmMmk/dcCDLJmfGghPBuvdfCGDlZ8xJ00rS8iXsG7kLEE7ueb/TZw
 9e32aHICjIE12LM2mIFoOcxRDpf9kcOVvuqKGpOqzZhGnIxnw4aE1HY4pknl9QUon6S9
 qEqnSjNAtniwBcKt6i4aifV14AgFMo3lAd27+Fcyczjc7soexvPmCSaODMoihIFm43/g
 xUSmoGh8Ez4OPtjouR25qsZVupDN2aGvsteQ6UzoqWOikNgTwGsucleZ0XIqJn3HlTbW
 dtaQ==
X-Gm-Message-State: APuU4Z+MLGx6q/buj8Nk5PDlzy1JsAA0xGKs9YoyH2Q9HphhGdv1CEfL
 8jm2D6LFGiLQnZrm0OM3xMjriX6uA0r2npdS/6WzyuE81EuWuWaPJh19R3+zYXT4d8DC7bq52PY
 TwjzMBYKUZ6OaoT/V8zVoaYPxfFpFsjlE8pWZU4yuTTAud6rZQX0vhkWSO32CIWhGPuLs
X-Gm-Gg: AZFdTZfCYEYIzFF5gvOfM4JPpK8rJ6AT0lbL4X/aTvBIBvVNuyV9Kz2VuqBRSlICl22
 nd1/xPfs5erWDVhTDcPr+hJ98Hozzh4Geg1ZNfImUGRgojV8MsFrkd8BdjgmXOPh/dWW+q+TKDN
 +30pjnHSJbCeuvElQTAwmeD9lAn9Cg1duYpH2aN0VKYIlbp3jYISGJT9EPe8mmqS9hxGeOB5BsF
 CkZMOQLgNC70Fu4Zy8fbFWb9Uw/xyKSYFU6KvcS5ZCwHHVfYsbZuiZhEFeAJAZ579QRh21ggZqq
 b2+TVJAHJikOW7+/xzaLxTTcM70OlSHJ4dCU+/PF7JgCVvgTC4ThfpEcHFZMP2vNIlXq78zmv1e
 DsFhvjXw4yRfAav7cA9D+vxSWUoajqrgfkN1Rwyt0TxZVh/qkf/9JrY1bkrgy1CPJTTeuD+0LrM
 vTJKzF4FWPOQBYMg==
X-Received: by 2002:a05:620a:2906:b0:949:7781:6a2a with SMTP id
 af79cd13be357-949bab506d1mr3010074285a.63.1795561802476; 
 Tue, 24 Nov 2026 15:10:02 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:949:7781:6a2a with SMTP id
 af79cd13be357-949bab506d1mr3010068385a.63.1795561801912; 
 Tue, 24 Nov 2026 15:10:01 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm458925905e9.15.2026.11.24.15.10.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31
Date: Wed, 25 Nov 2026 00:09:06 +0100
Message-ID: <20261124230917.88704-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXwoiYr9aGqDcN
 UZVH4ia8fjkWntTr0ZR3ykuc9bKyKmXmy0V0chkolHrhzRUGhWmPzmceoqMv0YMgKqXSGCP++Kg
 /Z8elEPT+LxHz+rKIuE/pdWuzjvW60c=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b06194b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=UgY5qV0q_vMF1zRxwbcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX6a4R9Ym9YGyh
 QEGjo80Wi9qHyRS6cX7PylPtC3JGjgMjPA1808oKmhtsuX8JAkOukvxdNsgP/nCSjjoArRLitF0
 d80A3xNyOHd6oFKhjUFpdirJK53y3lbZjZDrDX+VMxUhAxAV2Q3c2sa1re7tA50ZlZw2phY2ARY
 K4LQcTrkEdeimsH7zi7d8PJu9XFf806PGjcDKbpc5eyh9+QxCpCMTJLY8d0OMkuv1iwT5NIx12k
 oPxQGV0/Zrp2NhZfNGA4nexddgluoeUQSQqlKmmaBokGeK6eqOU/aqLZPYexjwx4cTmK7di+Wk7
 N4cjpi7EpI2qTxjPZX2jqhO81ijhjD0agNhrHCod83PZZVkYLDtZkysuhpA//5mza9Fe5MZPsor
 7RjpHp+OY1uGcgrgHuBnVnDzNW3UyeWEJs+EbpAu9rTkxDxkRjORTlqdBTqb9y3saoiXcxL4Rre
 LXwLHtB6JTeFwZB8eoA==
X-Proofpoint-ORIG-GUID: FM7U6n100L72XkDZpxkQ0zbCLGqBTnqW
X-Proofpoint-GUID: FM7U6n100L72XkDZpxkQ0zbCLGqBTnqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

cmd_read() and cmd_read_cd() check the 32-bit LBA from the CDB against
the medium size, then pass it to ide_atapi_cmd_read() as an int. On a
medium larger than 4 TiB, a read at LBA 2^31 or above passes the range
check, turns negative and trips the assertion:

  hw/ide/atapi.c:315: ide_atapi_cmd_read_pio: Assertion
  `0 <= lba && lba < (s->nb_sectors >> 2)' failed.

Reading the last sector is enough, e.g. a UDF anchor probe, so the
guest aborts QEMU just by looking at the disc.

Pass the LBA as uint32_t, which is what the CDB carries, and widen
IDEState.lba to int64_t so it holds every valid LBA and keeps -1 as
the "not a sector read" marker. The field is not migrated.

Fixes: b8d7f1bc5927 ("ide: atapi: check logical block address and read size (CVE-2020-29443)")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261112133455.604657-1-den@openvz.org>
[PMD: Avoid wrapping at 2^32 in range check]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Message-ID: <20261112133455.604657-1-den@openvz.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/ide/ide-dev.h |  2 +-
 hw/ide/atapi.c           | 22 +++++++++++-----------
 hw/ide/macio.c           |  2 +-
 tests/qtest/ahci-test.c  | 36 ++++++++++++++++++++++++++++++++++++
 hw/ide/trace-events      |  8 ++++----
 5 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index f5eaaf68e650..c6fd8d7eb1fc 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -101,7 +101,7 @@ struct IDEState {
     int packet_transfer_size;
     int elementary_transfer_size;
     int32_t io_buffer_index;
-    int lba;
+    int64_t lba;
     int cd_sector_size;
     int atapi_dma; /* true if dma is requested for the packet cmd */
     BlockAcctCookie acct;
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 0ea149ad8c6d..aec20f968da0 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -47,7 +47,7 @@ static void padstr8(uint8_t *buf, int buf_size, const char *src)
     }
 }
 
-static void lba_to_msf(uint8_t *buf, int lba)
+static void lba_to_msf(uint8_t *buf, int64_t lba)
 {
     lba += 150;
     buf[0] = (lba / 75) / 60;
@@ -71,7 +71,7 @@ static inline int media_is_cd(IDEState *s)
     return (media_present(s) && s->nb_sectors <= CD_MAX_SECTORS);
 }
 
-static void cd_data_to_raw(uint8_t *buf, int lba)
+static void cd_data_to_raw(uint8_t *buf, int64_t lba)
 {
     /* sync bytes */
     buf[0] = 0x00;
@@ -309,10 +309,10 @@ static void ide_atapi_cmd_reply(IDEState *s, int size, int max_size)
 }
 
 /* start a CD-ROM read command */
-static void ide_atapi_cmd_read_pio(IDEState *s, int lba, int nb_sectors,
-                                   int sector_size)
+static void ide_atapi_cmd_read_pio(IDEState *s, uint32_t lba,
+                                   int nb_sectors, int sector_size)
 {
-    assert(0 <= lba && lba < (s->nb_sectors >> 2));
+    assert(lba < (s->nb_sectors >> 2));
 
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
@@ -409,10 +409,10 @@ eot:
 
 /* start a CD-ROM read command with DMA */
 /* XXX: test if DMA is available */
-static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
-                                   int sector_size)
+static void ide_atapi_cmd_read_dma(IDEState *s, uint32_t lba,
+                                   int nb_sectors, int sector_size)
 {
-    assert(0 <= lba && lba < (s->nb_sectors >> 2));
+    assert(lba < (s->nb_sectors >> 2));
 
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
@@ -427,7 +427,7 @@ static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
     ide_start_dma(s, ide_atapi_cmd_read_dma_cb);
 }
 
-static void ide_atapi_cmd_read(IDEState *s, int lba, int nb_sectors,
+static void ide_atapi_cmd_read(IDEState *s, uint32_t lba, int nb_sectors,
                                int sector_size)
 {
     trace_ide_atapi_cmd_read(s, s->atapi_dma ? "dma" : "pio",
@@ -983,7 +983,7 @@ static void cmd_read(IDEState *s, uint8_t* buf)
     }
 
     lba = ldl_be_p(buf + 2);
-    if (lba >= total_sectors || lba + nb_sectors - 1 >= total_sectors) {
+    if (lba >= total_sectors || nb_sectors > total_sectors - lba) {
         ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
         return;
     }
@@ -1005,7 +1005,7 @@ static void cmd_read_cd(IDEState *s, uint8_t* buf)
     }
 
     lba = ldl_be_p(buf + 2);
-    if (lba >= total_sectors || lba + nb_sectors - 1 >= total_sectors) {
+    if (lba >= total_sectors || nb_sectors > total_sectors - lba) {
         ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
         return;
     }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index a95e68083f42..6f62d0188492 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -396,7 +396,7 @@ static void ide_dbdma_start(const IDEDMA *dma, IDEState *s,
     MACIO_DPRINTF("\n\n------------ IDE transfer\n");
     MACIO_DPRINTF("buffer_size: %x   buffer_index: %x\n",
                   s->io_buffer_size, s->io_buffer_index);
-    MACIO_DPRINTF("lba: %x    size: %x\n", s->lba, s->io_buffer_size);
+    MACIO_DPRINTF("lba: %" PRIx64 "    size: %x\n", s->lba, s->io_buffer_size);
     MACIO_DPRINTF("-------------------------\n");
 
     m->dma_active = true;
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 291f29e762c4..37f6dee0a7f9 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1737,6 +1737,40 @@ static void test_cdrom_pio_raw(void)
     ahci_test_cdrom_raw(3, false);
 }
 
+/* Regression test: read the last sector of a medium over 4 TiB. */
+static void ahci_test_cdrom_high_lba(bool dma)
+{
+    AHCIQState *ahci;
+    g_autofree unsigned char *tx = g_malloc0(ATAPI_SECTOR_SIZE);
+    uint64_t lba = (uint64_t)INT32_MAX + 1;
+    AHCIOpts opts = {
+        .size = ATAPI_SECTOR_SIZE,
+        .lba = lba,
+        .atapi = true,
+        .atapi_dma = dma,
+        .post_cb = ahci_cb_cmp_buff,
+        .opaque = tx,
+    };
+
+    ahci = ahci_boot_and_enable("-blockdev driver=null-co,node-name=cd0,"
+                                "read-only=on,read-zeroes=on,size=%" PRIu64 " "
+                                "-M q35 "
+                                "-device ide-cd,drive=cd0 ",
+                                (lba + 1) * ATAPI_SECTOR_SIZE);
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_10, &opts);
+    ahci_shutdown(ahci);
+}
+
+static void test_cdrom_dma_high_lba(void)
+{
+    ahci_test_cdrom_high_lba(true);
+}
+
+static void test_cdrom_pio_high_lba(void)
+{
+    ahci_test_cdrom_high_lba(false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2427,6 +2461,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
     qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
+    qtest_add_func("/ahci/cdrom/dma/high_lba", test_cdrom_dma_high_lba);
+    qtest_add_func("/ahci/cdrom/pio/high_lba", test_cdrom_pio_high_lba);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index c44eec6c5852..dc34b09c613a 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -52,17 +52,17 @@ bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"
 
 # atapi.c
 cd_read_sector_sync(int lba) "lba=%d"
-cd_read_sector_cb(int lba, int ret) "lba=%d ret=%d"
-cd_read_sector(int lba) "lba=%d"
+cd_read_sector_cb(int64_t lba, int ret) "lba=%"PRId64" ret=%d"
+cd_read_sector(int64_t lba) "lba=%"PRId64
 ide_atapi_cmd_error(void *s, int sense_key, int asc) "IDEState: %p; sense=0x%x asc=0x%x"
 ide_atapi_cmd_reply_end(void *s, int tx_size, int elem_tx_size, int32_t index) "IDEState %p; reply: tx_size=%d elem_tx_size=%d index=%"PRId32
 ide_atapi_cmd_reply_end_eot(void *s, int status) "IDEState: %p; end of transfer, status=0x%x"
 ide_atapi_cmd_reply_end_bcl(void *s, int bcl) "IDEState: %p; byte_count_limit=%d"
 ide_atapi_cmd_reply_end_new(void *s, int status) "IDEState: %p; new transfer started, status=0x%x"
 ide_atapi_cmd_check_status(void *s) "IDEState: %p"
-ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors) "IDEState: %p; read %s: LBA=%d nb_sectors=%d"
+ide_atapi_cmd_read(void *s, const char *method, uint32_t lba, int nb_sectors) "IDEState: %p; read %s: LBA=%"PRIu32" nb_sectors=%d"
 ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
-ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; aio read: lba=%d n=%d"
+ide_atapi_cmd_read_dma_cb_aio(void *s, int64_t lba, int n) "IDEState: %p; aio read: lba=%"PRId64" n=%d"
 # Warning: Verbose
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
 
-- 
2.55.0


