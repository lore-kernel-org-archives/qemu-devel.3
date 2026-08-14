Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B46C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wukuS-0001PD-Ji; Fri, 14 Aug 2026 01:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukuQ-0001Oi-Qk
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:56:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukuO-0004vu-Sa
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:56:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QTN91172830
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 smgciuXUP+64qXRZI6wPubeVFwIKDI/eTReyqAjv/DY=; b=DpOq7R+eDAz/xI0+
 VWCqE7MkIRJDMSAIcxc6EjXnK2iefIVbeYUU2Ma8Ekw2Qep3qrr+d3b0OKkHLfJn
 y2hgLieNTc0T0yacR8SDSBZJXQDsHQnPUXzxDDXm+TlbhHrH6lAyjNyhaHbpzuSe
 1aDSDLMmSX11BFKD5QxeZzSpg22JNrTVt9qkv4iJsTG7S72J2tzxFNxJjDXa2b3q
 AwvepPbPUqeUT8V6Vm8sTnqghGm+7TsyZ59wq93JoKjxxQbkKmctIFO9gIdR31dI
 BybNPdJ7B1uWRZ8r7r+Zr7cyDT2nPXc+DMTfR5B2nbqoo+6NzhPkPJGnMF+LcAkJ
 c2QGoQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1nugsfg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:56:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso65207185a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786687005; x=1787291805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=smgciuXUP+64qXRZI6wPubeVFwIKDI/eTReyqAjv/DY=;
 b=EYygcRXwc5TpOY4XyVZFauxGZ63gG6px3SExAP65UM4DunCpAdoLEYsUQEf5Yq4Kmx
 VsKiaThk4c/N0Jza+H4geoPVjjUrvGueqxSAU1resogDEYpILKrmvmELrVp95oH97aCt
 B8z7kwyXDSa/6et7D5JcwdhSobhJwZlHdf5LiyPdH7aHOwVOxdS0JbNshAqIBjtCu7ME
 DMpiW+pHaEOfk8/qAi+IGc+lhOVZsFFAo/8AcALq7aYjrIx8ub//5x7kOl19kPcnS2/l
 ubtzSkk8OaOYl1VAc9odPssCueCAaD+VjFQosavhgYqHm3qKgdTkXz6QPCoT2Wt73qS9
 MpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786687005; x=1787291805;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=smgciuXUP+64qXRZI6wPubeVFwIKDI/eTReyqAjv/DY=;
 b=KzsGD5b7GB0fJFLdAN9VON6OAd0zjNtsnUX1Gxlpp7bZmFeiACmMt6Nfkam1kQBZHQ
 Lm5FHCj2HewYOiHsIuZ5H0sV4LjzZZRPcY/4UqQU8v45NoSURYtgu/hNOElUzPWUn9ru
 2iRqYXILXwjmKJy6VNEnqo0l0jTTXQxH+Onx49pEp+DwFYF69JUMgguoR0NfsJXZz9lG
 u072HRMW7LGzJNBjz2E2xuOFGMbM5HZxTpzRQF7fwsF8gNbBJnQaOOfNtMr57eFGV/xI
 z2jwW6/KUhQDkouppbF6IW5dQtypyrJ/I939XG24xlMpHnag/4ctD9KmGvVRMVdIqzqg
 8y4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVRaR+Eo63n8XRG2Rs9oqCjD9GVr/SSmp7OkYtgMp+mkTV0q2m2yUbv1ny4y7zYaKAHXGSzweLxffO@nongnu.org
X-Gm-Message-State: AOJu0YwHshKsrQjuwZrP+b2UWjHtLMgE+trU7o7D2+8R3NQ6tln6FtIU
 6avD9H2jzDOc14zae3ZS9B9x6NPY7DkYWhtCCabRn1wfC9Ov8YoK/n98gZzZRBSmFKpa5C/BJ+w
 5O3Lc/7hFjre8Bj/PRitlDL0yORWtpzL96Wnl3N2Jj0FG3FqYMzU1/QiVYA==
X-Gm-Gg: AR+sD12lc+b6UD/OZvBf1YFoLg6aElGSYg8vNOy9R+xNCMLPUu0zz1k78cse35rTOsv
 X5R+KsX1o54I7IPkAGq0uh3N6PCIEDg+W+8FC3zdGi+6aLezXAXl42KsB07ZZ8HYK28QLtiNusx
 JMnkMMEPIaaRzKZZ85sy/SsakNP5/rv63ttFABk2R+ZW5lqmjH46SzOtYgpRT/Z53W13IYd6eKc
 pl8iLfUFGE3gB00n2oUuTpjyb7eKGXye4DGjVQY8Mhs3ii5ZnrdfHFp509i/ltarzy3eP0fMe9b
 ki8wHrQ/GxffyntrbNjHIwXUtAgpAP5BEg+kJML4TSQOue3c4jhz7NKW80WaTQ1kjjaCO1w0dSo
 htCaNJA2tWXP6J14q5gmJVNydEWKEFN96F4s=
X-Received: by 2002:ac8:5dd1:0:b0:51b:efbb:fbf with SMTP id
 d75a77b69052e-52d8548ad3bmr37629521cf.18.1786687004885; 
 Thu, 13 Aug 2026 22:56:44 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:51b:efbb:fbf with SMTP id
 d75a77b69052e-52d8548ad3bmr37629331cf.18.1786687004462; 
 Thu, 13 Aug 2026 22:56:44 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f1ffffdsm4927287f8f.2.2026.08.13.22.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 22:56:43 -0700 (PDT)
Message-ID: <cc83a207-c89f-4ec7-864a-db0115c4f641@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 07:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, peterx@redhat.com, farosas@suse.de,
 aik@amd.com, xiaoyao.li@intel.com
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-4-michael.roth@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812201938.198915-4-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0NCBTYWx0ZWRfX9Ucjb8MZYiGj
 hxwzG1HkefvtAmpC8lfA0DAQ6iew4TQCQr37WqAxLKFPys7T6V8jUEN7o66jTiP9M1NpX5OIlUD
 DaOXvAcN2p6O7pd3g6iyhFas0z3cY/EQ1JLToBtNopXFaVu5bnh5JGk3lKswnLMgC+IqJezIG+5
 6HCHbecGRbrS2XEH8BdXrghniISAF4Wt9yfu/wzb1BSlSzoQb0W7Rd/opdUS0+YXnKZeGcUK53r
 vHpTr6Uz1mqWuVzsay/3l2+G5DZueawpm4jGHa/n5A8ATj7181sw+LS6N8B3/loByO8GpuDOyeA
 KJqn9ZjBVHNYkMtleAS0A0LR6gR5XUgCnL6bCU3iKtv2CQZkEDqe737hxgPgXntOhDjx7R3demZ
 Sg6NRuIhQ35xxxDjOv5UNueRN34ScKVuouQ2xJ9hLkKMWBfQx6emhOdN7obCB9tm/JElp/s7Q41
 JsVN9lwmpyPeOWmUkvw==
X-Authority-Analysis: v=2.4 cv=drfrzVg4 c=1 sm=1 tr=0 ts=6a7eae1e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=QEH366t5Aw_EJZTCUboA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: y8GGbgzJnxm7uznJQggahHSQiMMbJtoF
X-Proofpoint-GUID: y8GGbgzJnxm7uznJQggahHSQiMMbJtoF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0NCBTYWx0ZWRfXzZTSg4yl7IUI
 mAUFwRcbus/jjruVZ5dCh+eMFy4DuueiMhNuXFOOGn/rfwRWdvR5MYlzUFOSTEMGWMHkgvuECZJ
 KU6n2Aa+9ngwsjd1+VppbFMU2h3//RU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140044
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter, Michael,

On 12/8/26 22:16, Michael Roth wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> So that there will be a verbal string returned when kvm not enabled, or
> kvm not compiled.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   accel/kvm/kvm-all.c    | 5 +++++
>   accel/stubs/kvm-stub.c | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 120cab1e22..bda2e25a66 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4758,6 +4758,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>           .flags = flags,
>       };
>   
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "guest-memfd requires KVM accelerator");
> +        return -1;

This doesn't sound right withing a KVM-specific method. We want to
assert() here.

The call in ram_block_add() is already protected:

2147 static void ram_block_add(RAMBlock *new_block, Error **errp)
2148 {
...
2185     if (new_block->flags & RAM_GUEST_MEMFD) {
2188         if (!kvm_enabled()) {
2189             error_setg(errp, "cannot set up private guest memory 
for %s: KVM required",
2190 
object_get_typename(OBJECT(current_machine->cgs)));
2191             goto out_free;
2192         }
...
2203         new_block->guest_memfd = 
kvm_create_guest_memfd(new_block->max_length,
2204                                                         0, errp);

The other one is:

2823 int ram_block_rebind(Error **errp)
2824 {
...
2829     RAMBLOCK_FOREACH(block) {
...
2834             block->guest_memfd = 
kvm_create_guest_memfd(block->max_length,
2835                                                         0, errp);

which is only called from KVM:

2776 static int kvm_reset_vmfd(MachineState *ms)
2777 {
...
2827     /* rebind memory to new vm fd */
2828     ret = ram_block_rebind(&err);

So maybe what we want is:

-- >8 --
diff --git a/system/physmem.c b/system/physmem.c
index b97016b1303..66ff74541aa 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2824,6 +2824,8 @@ int ram_block_rebind(Error **errp)
  {
      RAMBlock *block;

+    assert(kvm_enabled()); /* Only supported by KVM so far */
+
      qemu_mutex_lock_ramlist();

      RAMBLOCK_FOREACH(block) {
---

Or less aggressive:

-- >8 --
diff --git a/system/physmem.c b/system/physmem.c
index b97016b1303..2988d1dd6c9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2824,6 +2824,11 @@ int ram_block_rebind(Error **errp)
  {
      RAMBlock *block;

+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
      qemu_mutex_lock_ramlist();

      RAMBLOCK_FOREACH(block) {
---

WDYT?

> +    }
> +
>       if (!kvm_guest_memfd_supported) {
>           error_setg(errp, "KVM does not support guest_memfd");
>           return -1;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 3d34e3b99d..acbd0785e0 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -141,6 +141,7 @@ bool kvm_hwpoisoned_mem(void)
>   
>   int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>   {
> +    error_setg(errp, "KVM is not enabled");
>       return -ENOSYS;
>   }
>   


