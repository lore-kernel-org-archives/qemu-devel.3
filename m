Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE81606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UKakejyE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gZwLwJjg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0Ws-00024X-OM; Thu, 19 Nov 2026 06:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0Wq-00024E-RH
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:42:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0Wo-0000s1-T2
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:42:12 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuUK5598474
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0qdQ/YS0Xp1vHAS0W1gnr/rAZdnyyK45oJIz8r5yfVE=; b=UKakejyE8rJyT5ES
 MNeGy0c2CqFoUjFqWjEqibe8o8sJwjQUdjGM9Qm2J8+aZbrJw8TvTWXMgqqQLvsu
 NGJfLjpoe3bYm/UsfKUUeLiqa6H3P7pxL0XbNZqegHlkRUIBiUmLynscQE8tpBUT
 xfu+XzRrDaVjieCOaBiR1Ug41CrkPX5+7rgnkZA6f7+qMr5F+dIABnHME4ZoIFVr
 SoXWGQb8PzRBLaXJoen4lJ0vKUWEASAYqUBZkEP7b7CddMMm6aljGjVRC5AT9k0t
 a6v5ts81WU/AmOq/SLmXA4BmQglyvFikzwy9AF9WiDQqsmEoRh/qS+2oRoK+RaW5
 +yUUDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x708mpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:42:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d322fcso84994085a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795088528; x=1795693328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0qdQ/YS0Xp1vHAS0W1gnr/rAZdnyyK45oJIz8r5yfVE=;
 b=gZwLwJjg0U2x4jmuRTKZT4uPqoX7NlVLBSr+Th4T4OWd1BsPUxV/QeyUOkqery9vUb
 wLqlaQKx80NJF7MS5kpe5+go8C4NJ2M5sgUMAlrCkjap4PRekBaKdTi9R3doAdtID8/d
 2rSvTvg5HNUDZSkjGOfotrRToVCrIA6OJd1GFLqZjBg6G1lIcJnTJEIPu0ebmBW+YAHg
 Dl3iWHIdzQNEl1th/JmMPRi7pO/mprXao/fIVnu2Z0wILzHRyDfzVviWyS85X6ShgItL
 GMRS1npGJrb8+5+vnd4U4wkkwUkygNKtmmKfucYgKXKvB+/xgNKyQQGrBje+UB9AX7ry
 pXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088528; x=1795693328;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0qdQ/YS0Xp1vHAS0W1gnr/rAZdnyyK45oJIz8r5yfVE=;
 b=UBTet51y3g7Md5VxjCvQRwFUefUalyAgda2wm8qsUrCMmV3/0xJd/w141RYL+9C8PL
 WPkKT6gnwBSVkJb0yJBiCgl4N7hFrsYo64iEoGZ7fuCeQPFAmG1WtTTiLi8hqkV2kUhi
 yw/68A9Z60GYOfRiyGrcVXxuxO0Bih8Fc8te65G71ZDz7tUDUY0p3Ywe8Fpk4bJGScou
 IRBKjrKdI57LGc0yyy+vX1jRYTxMJFDAEe0aUBjVxvB4Zig7Xu71HpvKhw9Flz1YZG51
 L58+qpn5UH48S5s7SbMZ54h0LSyVzS3RAwHv9aeMDrEqSCDtriCryYaTrfqAaY0ye5Jh
 Fy5w==
X-Forwarded-Encrypted: i=1;
 AL+hErHptStcg1wai8o982x2B5T0TYHwE4pxhI1Bi08abJrbJ8wxsY8gkD4Lw8NGt+wNEX4PJ3LYahA5ch6b@nongnu.org
X-Gm-Message-State: APuU4Z9N3liwHNumvZrB7GZx6ugtIggHMuHGq1o0XWf2bq/V70YcPUZq
 1SCD2zjSC7p06hwt6S31Ou9+q7z7jklsAhd39QwEpXw46RjkGiEFeG4RE1/b22wTw084+wtbvWB
 HFEzyWRxL5DXDEO6z+xVIYjNFg1nbEmPZ61MKpEYzg0fCZbY7G6x69HYjfQ==
X-Gm-Gg: AYBFou2AgMvqVdA5D5Kmec8VysZIPfif8TqvkHq6F+S1uBAQWmk/jtMGtYjCGH2hZX3
 25uLlU6OLQgsXZvyDmwn9EYQjxkCRJ39QKkk9AdIONiVKYCqqS5HBIPpJ/YjrQvfoeyKu8pFw7c
 yD4/RWR8P/rOG+iYVjCzdl59+cPloPJkOsJOcWPvd76jjxXDoCObkq7mK//pjTRkNqW3jWjgfvX
 Gzx0gWqD0arSBQyfeo5+1j6QXTWTxLQkoR4dLkuwv+khe+a/TIdef3QfgpMqh469LdaAYXIlhjG
 9ArVYOvzmCTj5P/NknXgp4D0UDDGLdJFa0MgsDqLUstHo4wxEFSBN0nxQzigMEP0/1MHPMrBFyO
 zRrdmAaVdDPpZOW2jT4Q3TcyInPfyoeDQGe1wyVCrZtLFE80PAGrSCJScc1pM7Xsve4cI
X-Received: by 2002:a05:620a:1b99:b0:945:d7a2:4b58 with SMTP id
 af79cd13be357-9499960586fmr876476285a.65.1795088528115; 
 Thu, 19 Nov 2026 03:42:08 -0800 (PST)
X-Received: by 2002:a05:620a:1b99:b0:945:d7a2:4b58 with SMTP id
 af79cd13be357-9499960586fmr876474485a.65.1795088527659; 
 Thu, 19 Nov 2026 03:42:07 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65560ab70sm11135922f8f.30.2026.11.19.03.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 03:42:06 -0800 (PST)
Message-ID: <18e8c852-9870-4232-aae7-66db4672fdd9@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 12:42:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2] hostmem: allow building without KVM support
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Peter Xu <peterx@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20261119113309.1205353-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119113309.1205353-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sWbBKSpIbDRmoidDeWuxY9PqKIndGkc-
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6afee090 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dMDxPF1GtEdq01UuaR/ERg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=9qUTvQc-AAAA:8 a=EI4IS2iMIFUyLctKqVAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfXwMMAt3//0mzE
 jZ0WJSW66FZeLHkTBdMhBl4Cj2uCtJKhXyo/eWqPAOW3o53yLx0HO6OVbwrlQNHXmt26xTAcC5M
 wVi95VHPbqUKMTEnDt7XkgTC83CEnA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfXz1CVwLH2ovUh
 NjiIDYZRz0V9quQ6iWq/PRSjxs6gMnEN+Aw/OjFmftPAa4ctEyg5V4+sRNQRF2vh9amRDxXEKy5
 4y+O0zSMaEz0Di3RCg/9TCSazMPnbeNhynGcyWxGZ5nlFq52vl6FmkvfNzb3X5Bm772729j470V
 6iqStkICmrvPPbLjGNNV1s4f+uBIUnpp1LwKnztojfXX3Xq7Uw/tukleDs/QRjGcGa4Wjy64MpI
 3pq4lRyUlb7spkJh1wfHqQo1HovhpFO4WNR4ErlYtMxKe7Jxe5IznolxDX5UElIp9UAzsH3SAzQ
 fUyBWPtq4+g7euJPmWnvBDvoIgPrYB47EOp8RXvsE6t2/lJhpUVvncbvahzLPIaboEogQ7KPvqa
 +FrQu4Ray3lX40arTzbdnSlk2ZHAvUaRpWflE2y11U8aEnnjKnYJXgpbqvFy7WGrprEDyDSi7tt
 GYJS0VilegUvoaORzfg==
X-Proofpoint-GUID: sWbBKSpIbDRmoidDeWuxY9PqKIndGkc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190046
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-19 12:33, Michael Tokarev wrote:
> On architectures where KVM is not available and so including <linux/kvm.h>
> does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:
> 
>   In file included from backends/hostmem-memfd.c:23:
>   linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
>     16 | #include <asm/kvm.h>
> 
> Do not include <linux/kvm.h> because "system/kvm.h" already includes it for us
> when KVM is enabled, and guard the actual code using memfd definitions with
> <linux/kvm.h> too.  When using #ifdef like this, we can also provide a more
> clear error message.
> 
> Fixes: 7ca43d7ad02f ("hostmem: Support fully shared guest memfd to back a VM")
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   backends/hostmem-memfd.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 46489212a23..698ec930a5c 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -20,7 +20,6 @@
>   #include "qom/object.h"
>   #include "migration/cpr.h"
>   #include "system/kvm.h"
> -#include <linux/kvm.h>

OK.

>   #include "qapi/qapi-type-infos-common.h"
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> @@ -71,10 +70,15 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>               return false;
>           }
>   
> +#ifdef CONFIG_KVM

We prefer using runtime check (probably providing a stub):

-- >8 --
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 666593ff6c..d39bc71d25 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -62,7 +62,10 @@ memfd_backend_memory_alloc(HostMemoryBackend 
*backend, Error **errp)
           * NOTE: guest-memfd ignores seal=on/off because it always
           * implicitly seals the FD by definition.
           */
-        if (!backend->share) {
+        if (!kvm_enabled()) {
+            error_setg(errp, "guest-memfd=on requires KVM which is not 
enabled");
+            return false;
+        } else if (!backend->share) {
              error_setg(errp, "guest-memfd=on must be used with share=on");
              return false;
          } else if (m->hugetlb) {
---

>           fd = kvm_create_guest_memfd(backend->size,
>                                       GUEST_MEMFD_FLAG_MMAP |
>                                       GUEST_MEMFD_FLAG_INIT_SHARED,
>                                       errp);
> +#else
> +        error_setg(errp, "guest-memfd=on requires KVM which is not enabled");
> +        return false;
> +#endif
>       } else {
>           fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>                                  m->hugetlb, m->hugetlbsize, m->seal ?


