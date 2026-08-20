Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A0C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3vG-0007cB-IM; Thu, 20 Aug 2026 10:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx3vC-0007ad-Oy
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:39:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx3v9-0004JC-3z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:39:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KE7dmS3987793
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fvD9ke0N4Xr1wjAwqoimbGFZd+4Kj7ERmzAtGUyN/64=; b=kJns5wb3Cocq4f46
 wU6iaOYEhN7EEJimQrt9XbMA91PnPtoAmMbMvM0uFQ19D5VqQBeto5IBAdjNfoj3
 jX+vmekuE/r/lttgHYWomTyNnyY5zfR1Sramd/lN7k3pVmzaFLxAYbTe9JKPokgX
 vfjnWcsQSPK5FNxiflh4kNeWaCNYC2RZ0/mNZevK8EkMJm8AShLFmMtMb4xNxUC8
 JjRMmMK+qzI33C0E9XtSUyBPj+oNVmfAJlCvVjnncobyJsfVnOx+elYznOqbqx89
 1+8/Bi/xxFVW//pVClNiPbfr2EZQ7vmy3TK6PkSQfoV2hQxg9nq0hjXLw0xOkW+e
 bSAjqw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg893aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:39:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93730c7c73fso76898285a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787236742; x=1787841542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvD9ke0N4Xr1wjAwqoimbGFZd+4Kj7ERmzAtGUyN/64=;
 b=Xg6MhOCTdR2mzkueFnlXBsRefdNqhzkh13nHPZe3FGbekXGbRM7qRItFNkjl+qUxYw
 iaQSNIOOcaTNe22TTbrekDd1U4hYkSrZY0TNlZ8UkXb8fsyMVXQQUuRkDeCz6ZA1RDkz
 VztncTQBe+nDEz3kQLxp0OP8Jrm6H2TZiNxJikfWJfRb2+VDbRDl52bKnHRTZw+zQfdP
 7QGE8SWilVFYjySwgAvzMhNnYHQu+hLGOsTBA6qN8Lhfp2hxTm8PXypz9iZyR9o1snI0
 L7XwkNXEpZZnftXKp2RceiUjh0VId6YGhcRmj9rDrd8xbzXL611R2F5f56/ql1ZX4YlI
 8OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787236742; x=1787841542;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvD9ke0N4Xr1wjAwqoimbGFZd+4Kj7ERmzAtGUyN/64=;
 b=UB+jeIIs3x9Ush9VS+Q1sCAuebaFP7rRBjn7WPVLbifGesABhup4A4xUoRDLT5dPdI
 VpBkdJ4l6zsCiTqahlGBLa8fGfbRECS62RfhkokuV1mhkCoF64tnfmWpjciRXIzTs1rq
 E/fww9Rf/cDaaq+BPW/qMfNXZ0HJ7XJOL+cbSu2NNS6vncRAQ0Wen5Uqzd8NJwdtlO4d
 9NTV7SaZtwj/d9BDGxjNzN40Pq/EFpAi0kghx3yTRjpdBDrMkgIptwX5qboQY3IYVvms
 l5k8oUtsrq1WBM0sRHZtG03sm5GKuxCRQy3ITMIL90ZBHV+bt8rj4nkonPipQnsobJyn
 KEHw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrv9goiV69fD/tFT/3OjvdsnsPdF758xGHnCOAJsQ/amON+a1gQgH5pyfMcvKo+5IDiUelFlwkfy9UZ@nongnu.org
X-Gm-Message-State: AOJu0YxxANHCI7dcRyZRYRQYMi2GpuqVWK6rh71msF9SA4ACrpKQ1ekO
 OYPvAQIsfnpx1btqdxRJIMV1ziETXgm0ifjwqbV9hUQLfNvixUZyaLnPddiYnaPW6F+EPSzdXFm
 VsbzJw8qUr+7b6gpHFuRecbyJpimcwDjZXjNRFyF7gTy1wJKrF+P/XzM0XA==
X-Gm-Gg: AR+sD132vtxiDz9+DryG1fGEHcgNFWFBE2FhpO48ezkBzu+N+xYjLo+PqSoXEBDdHGY
 zziJpg2Dpb6rAizhoxqueSTONStY1F4pdCyu6LyHYIzR4p2XcbPyPxYKHzmKtVjLkc9TeeGsgiJ
 9mAgn4DEybpEAKdVkb8lii5UqyzjQUmqUCpK5xpnm4v5qzlc+5vdW6X+ogU9EvwMJ80QpT6CHnj
 SxN7En+FstR/pPRPv7lMYgxoXTVRqY5yxvKwVmgeFUM2TJmIGyelUJtkOILhjTinrahwrQvc0Wm
 7WIak+DEmurWj2209dLQ0ltiRJDnn/0tjZ9HjB9vc49ERx+2m2dY4ZI01ykdAMKJL2xU3jl9FLQ
 CSLdwT9PoHFMo7ZUpB83yBevJPNv3j+l4gm4HTuMx
X-Received: by 2002:a05:620a:6413:b0:931:328:fecf with SMTP id
 af79cd13be357-9371e2f095cmr1348858885a.26.1787236741991; 
 Thu, 20 Aug 2026 07:39:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6413:b0:931:328:fecf with SMTP id
 af79cd13be357-9371e2f095cmr1348852585a.26.1787236741598; 
 Thu, 20 Aug 2026 07:39:01 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd728sm208741335e9.3.2026.08.20.07.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 07:39:00 -0700 (PDT)
Message-ID: <54f7243a-aae3-4f1a-a213-bf302fc1b7ea@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/49] target: guard MonitorDef tables with CONFIG_HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-42-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-42-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX7r6OiQZfaqPs
 4Q/jlv/ZmYL2dX5KZ+Z1jrqjfZlfNiCKOzvpdJnLYHhhHW0nFYrDku7Cwmhyj9Jojl5MNVziHCI
 44AgqZDzE538k5WzkRu9ChoaT3FpDHc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfXzZcctyQLre5G
 mleKy/KiQdYMTqVMliZojuc2q46r5f3ZU5rp1SEJy1E+yaRxZGf5/lDmJIDP5Nrv+T8YEM88e2e
 lltH3wO9bJVPmWxy48V55sMub4QI2++IiPm/MmW9pY4j1O/Fio3i0DXy1rVV//IV0PBbmOy5f9Q
 gzVOvN0v4EQx61vNKUBMsYnb2DP/e2ZYwheu/hv5c8yHZet08f8Rl3rESrtPoxcP7m0nKKLMSmM
 I4unhcAqlGIMtWO7/vvcWcBc6tHoc7fNIPImYYGLiWkgav75BE4dWJi+ujbPvvCq0VjlcBEdUug
 yMSSYF8hg7fr9VKf1l/y0+gV/mkn2jeuZ2Oz2Qva1aBmKt4GsjwHesdW0rg9k8/VDpN3MDI2yxH
 TL++mFMji96W/RcpjrhZ4+gP7ortdFBPLC1gVNS0CJ2/Ih1cwKWjIIjQN6DxmYdYQV9GWT77OCu
 K9uH8J54HsCqMQ9s6fA==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a871186 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=WaTGUccEzQP_nEDBHA4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: wNfNCnwBuPNebMT8rqOblWHxDai4sTCR
X-Proofpoint-ORIG-GUID: wNfNCnwBuPNebMT8rqOblWHxDai4sTCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 16/8/26 21:13, Marc-AndrÃ© Lureau wrote:
> Guard SysemuCPUOps::monitor_defs field and the per-target MonitorDef
> arrays with CONFIG_HMP. These tables are only used by HMP 'print' and
> 'info registers' commands.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 2 ++
>   monitor/hmp.c                    | 4 +++-
>   target/i386/cpu.c                | 4 ++++
>   target/m68k/cpu.c                | 4 ++++
>   target/sparc/cpu.c               | 5 +++--
>   5 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 9a45596169a3..e56eea18b785 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -109,11 +109,13 @@ typedef struct SysemuCPUOps {
>        */
>       int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
>   
> +#ifdef CONFIG_HMP
>       /**
>        * @monitor_defs: Array of MonitorDef entries. This field is legacy,
>        *                use @gdb_core_xml_file to dump registers instead.
>        */
>       const MonitorDef *monitor_defs;
> +#endif
>   
>       /**
>        * @legacy_vmsd: Legacy state for migration.
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index e5f8b9c576e0..3c70adcd35bb 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1725,13 +1725,15 @@ void monitor_register_hmp_info_hrt(const char *name,
>   static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
>   {
>       CPUState *cs = monitor_hmp_get_cpu(hmp);
> -    const MonitorDef *md;
> +    const MonitorDef *md = NULL;
>       void *ptr;
>   
>       if (cs == NULL) {
>           return -1;
>       }
> +#ifdef CONFIG_HMP
>       md = cs->cc->sysemu_ops->monitor_defs;
> +#endif
>       if (md == NULL) {
>           return -1;
>       }
Logically we need to skip more:

-- >8 --
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 22b1972d346..cb4e070fc4c 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1726,12 +1726,13 @@ void monitor_register_hmp_info_hrt(const char *name,
  static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
  {
      CPUState *cs = mon_get_cpu(mon);
-    const MonitorDef *md;
+    const MonitorDef *md = NULL;
      void *ptr;

      if (cs == NULL) {
          return -1;
      }
+#ifdef CONFIG_HMP
      md = cs->cc->sysemu_ops->monitor_defs;
      if (md == NULL) {
          return -1;
@@ -1749,6 +1750,7 @@ static int get_monitor_def(Monitor *mon, int64_t 
*pval, const char *name)
              return 0;
          }
      }
+#endif

      if (!cs->cc->sysemu_ops->monitor_get_register) {
          return -1;
---

