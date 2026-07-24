Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132BCC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnI28-0000rO-1K; Fri, 24 Jul 2026 11:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnI26-0000r9-AF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:41:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnI24-0003eL-FE
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:41:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODbNtu3335787
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 15:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xs+x57VaTtvQntEpQdo24DOQ9c6PH4+cdlVgZZDfWOk=; b=mjC49spADEFKAqcu
 AMvyZZ+qoD92D4h2pNb4w5w46AJZLSO6R2IDDoLp/wkmCISM3/hKdR3o+ar4NeRA
 INFuLCwH+B74fcznwl4im7E3eZ36VNv1E/Dr7IUi0IModOlXcZ+CqEwstuN4kmcc
 oXPPb8EjH246k/IFpBo7tVgHWXPqTO7BdZJycEZ+62z2mrD/Ai9yniqVlq+vNmRd
 4HJ6bC42AOI7oWmSXZjUH+klXpyYyhrt2c3WtZR42eKKQPG54CITEV1dsKZDJ1Kr
 IstkKf3KQzOgfvsw/bQeufI3TidsB+QpZb8eTUlU0MmRpxhW8rQVAu/R2z8YTAoq
 Eopz3w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5bysd0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 15:41:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so7637511cf.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784907708; x=1785512508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xs+x57VaTtvQntEpQdo24DOQ9c6PH4+cdlVgZZDfWOk=;
 b=TeIOncCJIK75qn3r2Ga+zPokb9Hdt1BMS1XUjN2BAd+i2xDVAqKuYWsku69/3Ssy5T
 RgggIwykWrEgwWu6ani+PaVgV+WfPDrb4ELaVmcGuJ8ciwkfuQfPOPrcY8cpGs7L1Ihd
 g5nkuxvbwulvJ5liMByeMJiny5opJmMZdguAFO8hCD9VkjH3ZLadbiOFdUAAFFHLeLN2
 NJj0WjlFDDklw/ZnYYSieOSrNxvRhEWfdGSTPd0tVM8EPS0QjrN71LRtoXtEdErMe5FG
 F6/mwFoEg33nM9Sho53WXdmnHW9McVjLAmNQJ7HSc9tOg8hS15eL1QK+wXE7VelMI2xt
 ZvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907708; x=1785512508;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xs+x57VaTtvQntEpQdo24DOQ9c6PH4+cdlVgZZDfWOk=;
 b=fL5igwyKLY5+y7ZH0FjCqMk9hv+WDI1mwdJO2rZ4SNPXvYJ0iZV3LdY3C159+2m+62
 8PIxtRJyH/0rS1DTk//RXxsKGog0VBemUGMiWJcBlX/UP9XO/CXJGHbjxnmAui8k9bxa
 wiZgNAVbNW5zyj/laxxYc4W1dwjDYAYZrJhREEEg5fLRs+MSbDjmPd8UT95JnpWOW1WU
 QeShjdukZfaPeeZJ4+4nDKDhc5ryGEKXe2dp7kc0ZKiS0bVXIg1rU1nFZpOpsBbD2oe8
 I++DSvr8cG1nqMKQV862gwj9cS0pNA9SX2aq4LLTDZv1+ZoIeKG61IFS5ighBcQH5YsA
 SxVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9dql5O8OaEnyhWDkaJljEIhlAwK7x/24RYWB6ckTuCOHglvlNc9TMalD5doPZtPx280Ogsj4w7jKb@nongnu.org
X-Gm-Message-State: AOJu0YzA+gkrHSEQO9EdLxeufrytvSGTrEY4mmJyC9e4zA0vYR5zTVxr
 NdtGoM8gSr99EiMS0DRS8B2nG0eBe6DmzlAF/Ip6KJ/0qxLe3+XMAb7b7NbExTNgJpp7P01XrjT
 02VMru7GuTuT6JyynJMwDhiQRb5BwjNXwX39D6HnDuJC2mhIvnwNsnWY92Q==
X-Gm-Gg: AR+sD10U63P1RhR2r4emO+T6/RZwqlEBDj/9ORGqVmUo7XzhJ7My0RgrRe6B9tMSWbT
 rN4JVxrbTqoyJW1dlOqukbR2qoTgKSEtYJDx0bdyMCNem1Q2CyOq5j0INdo5iQU++SQJQ56Rl8b
 EbV3fy9CXGaXvYJHU6urLnFwDlwO6dS07Gc6W1o48koH2EdpiJbhlVyUSpKQVAhVOBNU5KS4QkG
 5lhvaKw4rXKPC3Dr72SnauzDz9YGTWmwg81pqTFs4qelhRsxTQHycqT6FjXEdaTzfsU6ZyNuixk
 boX4l28mkR7D6sdBJ4UBYmg5lxfSwU8BIC5rpQTGdfy9qhlrCLjq6Cv2M9aHqNKfWG7pDj+o7dJ
 D3I3FePBYPFnC0MqGGKgHSEYXp/Uq8NC2zi4hK1Wf76b0srttOoM=
X-Received: by 2002:ac8:58d2:0:b0:517:6508:e1f4 with SMTP id
 d75a77b69052e-5283deef172mr73103071cf.42.1784907708180; 
 Fri, 24 Jul 2026 08:41:48 -0700 (PDT)
X-Received: by 2002:ac8:58d2:0:b0:517:6508:e1f4 with SMTP id
 d75a77b69052e-5283deef172mr73102671cf.42.1784907707588; 
 Fri, 24 Jul 2026 08:41:47 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm25466665f8f.33.2026.07.24.08.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 08:41:46 -0700 (PDT)
Message-ID: <fb57df9c-66aa-4671-80a2-a5e98a0fa7f7@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix ROM load failure handling in vfio_rom_read()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, mcasquer@redhat.com
References: <20260724092413.348354-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260724092413.348354-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: na-6L8BZmZabdamAw8X7l7cHQNR61Kzu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfXyT8DH5+wQvnH
 poL/kZMSFFBfYvuvXwvnbnqlKwygmv/okMy94QW3WZcefT7wOszG3he2jcYoUI1biB6nxek8GJC
 m4lhW7msjBEi+0GTVu0xyFrL+b/M3cU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfXwimLQICzb4U3
 BVwJ/WwNEH9yq5PBNiQ6wQfDb0JUIRk76zokvRs6cAz3XJ28TKF3UtWwKQb4BKvK1BQSQneRRcI
 zDxYamKlxxXwDk2vBBNEZf31TltBKJAlUIaCMgwhl96zoUoJOjK0sjMPoJktWDAnLvH3btkGQjU
 cUfyWD+8UeGE5HwbR3X5t68zv21Z3Xg1oNbHxQY+KOdxfT7Qr3IoISTpqPjRFCvFbzKu4Adkx8c
 ECV7B13Qi60jE1abaQGD8W1JBQqAEwbeuOkAGioeLrhsg23mWk26Ty+Os6AbJ78Dp4+oP2nNLhh
 03akeQPhNZ/6xZqOexrD+apLFN74MK9auHR+tOteLuPknXdlq1n3Cm+TUi1xdK06pe+eORbJqmG
 srJwDTk7sbU2uHShCiHykkQEKJw4UwdIinM5BLIIhSxVTSUK4YdZZLPYh8Q2I3WBcVfxnI4qwSh
 JN+bQ6JM1T5nusQsRFg==
X-Proofpoint-GUID: na-6L8BZmZabdamAw8X7l7cHQNR61Kzu
X-Authority-Analysis: v=2.4 cv=GMA41ONK c=1 sm=1 tr=0 ts=6a6387bc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=3uXI8EjjiLU3y-OuUB4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240141
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/7/26 11:24, CÃ©dric Le Goater wrote:
> When vfio_pci_load_rom() fails, vdev->rom is NULL but the memcpy
> still computes a source pointer from it, which is undefined behavior.
> Guard the access and return a 0xff pattern instead, which is what
> hardware returns for an absent ROM.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a3147d28665abd29fd804bd08bdffc3c7440033c..16d4f70ea58c9e5b174dd57950df55dc2ab91f6f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1176,8 +1176,13 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>           }
>       }
>   
> -    memcpy(&val, vdev->rom + addr,
> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> +    /* If ROM loading failed, return 0xff pattern */
> +    if (vdev->rom_read_failed) {
> +        memset(&val, 0xff, sizeof(val));
> +    } else {
> +        memcpy(&val, vdev->rom + addr,
> +               (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> +    }
>   
>       switch (size) {
>       case 1:

Maybe simpler:

-- >8 --
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e630..d06a2d76523 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1151,13 +1151,18 @@ static uint64_t vfio_rom_read(void *opaque, 
hwaddr addr, unsigned size)
      } val = { .qword = ~0ULL };
      uint64_t data = 0;

+    if (unlikely(vdev->rom_read_failed)) {
+        return -1;
+    }
+
      /* Load the ROM lazily when the guest tries to read it */
-    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
+    if (unlikely(!vdev->rom)) {
          Error *local_err = NULL;

          vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
          if (vdev->rom_read_failed) {
              error_report_err(local_err);
+            return -1;
          }
      }
---

But we can also rewrite into a more readable code using ld/st
(also avoiding memcpy zero-sized):

-- >8 --
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e630..af51c898f50 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -33,6 +33,7 @@
  #include "migration/vmstate.h"
  #include "migration/cpr.h"
  #include "qobject/qdict.h"
+#include "qemu/bswap.h"
  #include "qemu/error-report.h"
  #include "qemu/main-loop.h"
  #include "qemu/module.h"
@@ -1143,42 +1144,30 @@ static int 
vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
  static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
  {
      VFIOPCIDevice *vdev = opaque;
-    union {
-        uint8_t byte;
-        uint16_t word;
-        uint32_t dword;
-        uint64_t qword;
-    } val = { .qword = ~0ULL };
-    uint64_t data = 0;
+    uint64_t data = -1;
+
+    if (unlikely(vdev->rom_read_failed)) {
+        goto out;
+    }

      /* Load the ROM lazily when the guest tries to read it */
-    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
+    if (unlikely(!vdev->rom)) {
          Error *local_err = NULL;

          vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
          if (vdev->rom_read_failed) {
              error_report_err(local_err);
+            goto out;
          }
      }

-    memcpy(&val, vdev->rom + addr,
-           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
-
-    switch (size) {
-    case 1:
-        data = val.byte;
-        break;
-    case 2:
-        data = le16_to_cpu(val.word);
-        break;
-    case 4:
-        data = le32_to_cpu(val.dword);
-        break;
-    default:
-        hw_error("vfio: unsupported read size, %d bytes\n", size);
-        break;
+    if (addr < vdev->rom_size) {
+        memcpy(&val, vdev->rom + addr, MIN(size, vdev->rom_size - addr));
      }

+    data = ldn_le_p(&val, size);
+
+out:
      trace_vfio_rom_read(vdev->vbasedev.name, addr, size, data);

      return data;
---

(untested).

