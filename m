Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCE606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zd1wwqOX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dSqVN67O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5Ss-0005sB-F7; Mon, 16 Nov 2026 17:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT5Sm-0005qI-Sn
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:46:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT5Sj-0006Fw-R2
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:46:11 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCQfK2711468
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ERKBhE8jKs0wzasLLWP314CwjkQ0hH8pBgYBybJZ/a0=; b=Zd1wwqOXR9OMZ+IY
 F5HksWS2FqTD9PucAVdj/21CQ6zpPrPFvYz13d57mCmJaccuBOhkIDXe9Shgk2C6
 aRWA+FdXfsLW617YBQ/ZDfBhmoGdI2t7VvLM8AnKy5k44ZgwEGIhQ+SuBuI8yBVl
 Mip6hBjoOgMe0eQMyqANryvC9yE80WZxtVrxCgigUuGZNXv9qG0DXOvM352NS5iC
 lYhzz6pVOVXzkjBHz4EjpdwoFouecLENOtXywYqVzq4V4o2mq4ztdd4tQa9qPUOJ
 NBVpRTWJp+LaFbJ8vfw2z4FWuKLm3yC8NBW5sKR4jGUsYDcPg13ROQudD3TnEXLW
 X1mStA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htg8ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:46:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so72684585a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794869167; x=1795473967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ERKBhE8jKs0wzasLLWP314CwjkQ0hH8pBgYBybJZ/a0=;
 b=dSqVN67OYAoVPHG2A7U2lAurrU128K4Cl7KgZBOXlecaoFiWxgID23SlENxoqJlGVj
 uGq0D9iujCtbvckIi5oHGu2ykdg4GLFvwX+WBWO7cHUO1IvS3P6IWhV3Nie2lIliQSA/
 xTqxAHp+q44bjHoFOzRwSZxFmT96iAIJ6tuwY+VcyW5tCeg3Y5azLlvYVUZQoloHA8Lf
 8d3CdPC4/7AiPk6e6AxCOTDN2Gw42kVQyrIZLStmvtVJF4l/FwlAc0FsS9x/owpTGCbG
 iU9M+79jkw79CxGCeVwG3n6rlMwk5wMJ4oBbGw6xZHLVdA143+jQbQVZ3qxePxzhuR/p
 J62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794869167; x=1795473967;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ERKBhE8jKs0wzasLLWP314CwjkQ0hH8pBgYBybJZ/a0=;
 b=takXhYWLAgpYVPXkjmKnupkhxNNpnMkqBlGJPfPWGpXkQGrTcq44oDqvBcxcQchkHz
 6jOgAizprcZLrqabRL0+NeiiBaPYvCHn+OT3a/36OI+gcs0TVcsJqYHUfNQVTeJYZRBg
 hHJW3QY7G2I0lKlYXnsjzsSPhIitBad0oWwcsxjVIzNvA/C6wsao3yHVL4Ue3xXZQI+N
 9tGPRcBDrscxQ8+oaLyLhfdRDOiisZYGrX8isOnKayDhwuP5U+onVoDLWByvVLFQUh6f
 wgF6THvvhso1bIm35EAEmksTgGOMXCuOpwvF72t776Ww3/ayEPo4dEsUo/XX9bGmkSMf
 cP1A==
X-Forwarded-Encrypted: i=1;
 AL+hErFtXU7lbk+c3lWAXRSdIn/+Q+Qx1E9LMapWrvlcstS+CVJGY9xlawyxBE8D/a5hEh/bZTA2EuqhFm98@nongnu.org
X-Gm-Message-State: APuU4Z/fMhPx9SU/NSuyJsfVMjPVQly6yApc3kqnAeMWYGBz07xBO9Xz
 UP1DUpLg+SR/URzop6Cr606kodqTf16GZ5pfK0WYuWKODmPWBooS4yKluYauq0sGxyPd9oviKcZ
 z+zcNYpXK0af+FX0rwOkdxWqioA6v/gkHqIKL82O6IsuleNAk1xEkhBS4gw==
X-Gm-Gg: AYBFou1BFIXJF52HDdnoAehUrGOLxvXvwA/R4p/rNQp1g5MhzLL0Hm7LJjIY3us4/4F
 TFssHDcZg1cial47uvsxXX2XE7IsG02yk2RkrE20yphlyIZk8j/9REEiLLv9Ejq4HgbDqnZXbHf
 ZEkj+/9HK66O5JrNk9Glk1K0dLFcjlcdW6k2+kc6nZGKfZ9AZrsHZ8NWifSfkfC5HL2yNpYQJeq
 rfBVc5U3m4a8GiEqDjw2uTWNd22Ny4+48cuOfCh/L5uvfS+llvYGDkW+zk9ynnhShTw7gw0Froi
 oFcph54viLFL6+4i0l8AciwszQC71NhnqKwyOjQbJUu/PauO2lvUTV/HBxuYNQms0OYLX34MQY4
 c3foKPMwE7/jhLzmZdzTRBaoOW0VZo5IGiyLQyES/kqXOpFa8LviKPG1SmPTw4oLYyJdURqmmKB
 sWdPTDyH8=
X-Received: by 2002:a05:620a:2915:b0:949:70c5:c0ce with SMTP id
 af79cd13be357-9498b8ec2dcmr157586485a.19.1794869166696; 
 Mon, 16 Nov 2026 14:46:06 -0800 (PST)
X-Received: by 2002:a05:620a:2915:b0:949:70c5:c0ce with SMTP id
 af79cd13be357-9498b8ec2dcmr157581285a.19.1794869166036; 
 Mon, 16 Nov 2026 14:46:06 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f77fc47sm24473498f8f.22.2026.11.16.14.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:46:04 -0800 (PST)
Message-ID: <7fc8f4c9-75dc-4fe7-8447-f9cba967f4b0@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:46:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20261112133455.604657-1-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261112133455.604657-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX4dMvQjxyviVE
 N6QqZbwlmlPwCpCKATM8N2gWo2oZorLvlUWl3Leipb8yWrsuaI8GXvo7S0sR4NXlSJJMcxAE/5S
 NaSk5L9KJ/yJcg/XJ00qteMMb6bNbMM=
X-Proofpoint-ORIG-GUID: QJ5ZpLM6Ips2ZyAvwHsW8RlRKsWjWzsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX32pQs58+NEUi
 GX/ASb5e3p34AwFKcoToRg9QivIz6IFu7tPuZUq1Zg/HF8FOF/bNq0UXxtQIN1Pcrger/e+Ard/
 emk43oL8xbZozGV1IJDe5yAR6rCumbwCjPzD7o7oEL70DF5z12BKWYdoSEOkOH2SKd06HKoEZq7
 ZKPJSdIsFpDd59rKmVx1pfPaM6JG8FrWulrzc1Giv8nwaD8Neph87k2XPfMJsEryNuxvCFgWwV2
 TzK5/HqLnRNzHt4almiHe0dNIt5/w7htLEMR7dEUg7lvWkIWXQ+/+IHJrk0BPNRFoTjgSOBTY11
 aWRhPTFjJJo5mgs6hW0RICvy7bdViPOX2YwTFIkDzbYktzvYuRJ7numwMKmaO9RPzJNI9S65NRk
 WiFYeQmgxeAZcd1U4D4aX73m4T70Q+6oEPz8gCzg/OwjdsecgXeeOezZL3KSAedTQWaD4lNtO6r
 ao4Qyd4u2rQMkiuDtOA==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb87af cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=OkEwENNiyncnOW3GYLwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-GUID: QJ5ZpLM6Ips2ZyAvwHsW8RlRKsWjWzsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 12/11/26 14:34, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> cmd_read() and cmd_read_cd() check the 32-bit LBA from the CDB against
> the medium size, then pass it to ide_atapi_cmd_read() as an int. On a
> medium larger than 4 TiB, a read at LBA 2^31 or above passes the range
> check, turns negative and trips the assertion:
> 
>    hw/ide/atapi.c:315: ide_atapi_cmd_read_pio: Assertion
>    `0 <= lba && lba < (s->nb_sectors >> 2)' failed.
> 
> Reading the last sector is enough, e.g. a UDF anchor probe, so the
> guest aborts QEMU just by looking at the disc.
> 
> Pass the LBA as uint32_t, which is what the CDB carries, and widen
> IDEState.lba to int64_t so it holds every valid LBA and keeps -1 as
> the "not a sector read" marker. The field is not migrated.
> 
> Fixes: b8d7f1bc5927 ("ide: atapi: check logical block address and read size (CVE-2020-29443)")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/ide/atapi.c           | 18 +++++++++---------
>   hw/ide/macio.c           |  2 +-
>   hw/ide/trace-events      |  8 ++++----
>   include/hw/ide/ide-dev.h |  2 +-
>   tests/qtest/ahci-test.c  | 36 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index 0ea149ad8c6..2c928de8db8 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -47,7 +47,7 @@ static void padstr8(uint8_t *buf, int buf_size, const char *src)
>       }
>   }
>   
> -static void lba_to_msf(uint8_t *buf, int lba)
> +static void lba_to_msf(uint8_t *buf, int64_t lba)
>   {
>       lba += 150;
>       buf[0] = (lba / 75) / 60;
> @@ -71,7 +71,7 @@ static inline int media_is_cd(IDEState *s)
>       return (media_present(s) && s->nb_sectors <= CD_MAX_SECTORS);
>   }
>   
> -static void cd_data_to_raw(uint8_t *buf, int lba)
> +static void cd_data_to_raw(uint8_t *buf, int64_t lba)
>   {
>       /* sync bytes */
>       buf[0] = 0x00;
> @@ -309,10 +309,10 @@ static void ide_atapi_cmd_reply(IDEState *s, int size, int max_size)
>   }
>   
>   /* start a CD-ROM read command */
> -static void ide_atapi_cmd_read_pio(IDEState *s, int lba, int nb_sectors,
> -                                   int sector_size)
> +static void ide_atapi_cmd_read_pio(IDEState *s, uint32_t lba,
> +                                   int nb_sectors, int sector_size)
>   {
> -    assert(0 <= lba && lba < (s->nb_sectors >> 2));
> +    assert(lba < (s->nb_sectors >> 2));
>   
>       s->lba = lba;
>       s->packet_transfer_size = nb_sectors * sector_size;
The range is checked using unsigned 32-bit arithmetic, so we need to
do the addition in 64 bits to avoid wrapping at 2^32. Simply casting:

-- >8 --
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 2c928de8db8f..bc18654522d0 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -983,7 +983,8 @@ static void cmd_read(IDEState *s, uint8_t* buf)
      }

      lba = ldl_be_p(buf + 2);
-    if (lba >= total_sectors || lba + nb_sectors - 1 >= total_sectors) {
+    if (lba >= total_sectors ||
+        (uint64_t)lba + nb_sectors - 1 >= total_sectors) {
          ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
          return;
      }
@@ -1005,7 +1006,8 @@ static void cmd_read_cd(IDEState *s, uint8_t* buf)
      }

      lba = ldl_be_p(buf + 2);
-    if (lba >= total_sectors || lba + nb_sectors - 1 >= total_sectors) {
+    if (lba >= total_sectors ||
+        (uint64_t)lba + nb_sectors - 1 >= total_sectors) {
          ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
          return;
      }
---

Or nicer comparing against the remaining sectors instead:

-- >8 --
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 2c928de8db8f..aec20f968da0 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
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
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


