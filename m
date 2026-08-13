Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3CEC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuWmc-0003Ci-40; Thu, 13 Aug 2026 10:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuWmZ-0003CC-M3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:51:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuWmW-00067b-Lx
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:51:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DCL9aN1519947
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 14:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y8ckVKjYLbcQChEv8+GikNCitpge7F3SB+rvHJpseCA=; b=Ua/0d4Tq/X2Z/EGJ
 egx8HGyTcFOztR0TRPh45XvN8DqWMkkxDO+0vWk+6fEE1q0uUy1xt+WLz/eslLXh
 v3EdWcjJGWIem2JEb8rCu+F1Mat5mZEuDUUpeF0+/DFWcTPJQ4GbXPlwr0eSI8gt
 mXumCEmU1hQHerdT1Zpeg+MADrV4vcjsUsAWKjtkprR48i1hX4v5yAe/+/Og/vPn
 jNA9QmmUpzcR4LAaljA3q0VyzpJUOObAWxH38oAiPJVKQNTqjDqZK+wxhWG/dzl/
 8952A62mYDm+yapOohq6wmqkv/Q7IaQwrUotiSUXRdKjcFJb59LnRPBQIiZbjncj
 UfXEsQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0xsk478v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 14:51:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d7b3b6aa2so5085751cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786632702; x=1787237502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y8ckVKjYLbcQChEv8+GikNCitpge7F3SB+rvHJpseCA=;
 b=ftl4ItNfiXMHJEj/E6Vz9ymviS+VIljMY0TVEHyOOptTbNma5bALLSoOIy24jcjIwz
 qi/xz6gUx8oH8MNVZIbFOdY4V5Jcpp8E9jRWOcaptl6VHg1Azeg9QvnsBko8CrBinznX
 +DVmF2RSx5OHFI6RRLWSDLLNrcO2VoW8wPZhzvi1Rzt6SnNGpV3bz/vaffFBFtj7fyl2
 2vjunwQnJq6/KWQ1wfEPjRb+BjijQbUTBF+qo3mV0CJKv34O4zwz8jCeBffAWPa0QySA
 3rJanHnRE5nGxl5NCKAVZyf/AN+lowD4WTUPWFSPun8uXArKpKw+RZngIvR9AQTaRr3a
 6Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632702; x=1787237502;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y8ckVKjYLbcQChEv8+GikNCitpge7F3SB+rvHJpseCA=;
 b=kZANNXQSiwyJkKLL3xLmerhSbrBkqUEwFd286vyEdZ4CriKWDcTpaYTwUqTwhKws2p
 5czPYJJOLyrkm+dN2p9UChU53LByiWqNAITGyO8GiTVaBUB7aFhDyDB++L0oZhWACqqm
 nVL3AVpwb2i1wQEoweKYftb6JsGDpy1w3x8UZ04RuKJLdcjlHYpYiJ8nrOjmM+G4gW4D
 MDSgKWjrjFIfePU/Qw4A109WUoubWNNLWVVHv6xoauxVEcLb0xPwia+29kXhvH2ysr1d
 WO0hLW1cvb0lusd1uH06+F36KA6Dv08Ya1V5bGo0uUjYfFXOH6CF7zgp2qpSmoYwKETN
 uUeQ==
X-Gm-Message-State: AOJu0YzU4u8EIA8Gr4ZVKKsK3HjJ2/FhiBELEVw4nP5fL6V8df551Ccm
 tK9obMst3rWOsTc9/UBvmKbiY12nAhq1Qg0SjvvNlBmi7SZc3faRIs9NCioljTYalX5uSWCQZ7z
 A0+GeUJ+v1JEwziAPY9ha5vppXxjMBheJ5iN06ptG1oRnazYB/naz7CObAQ==
X-Gm-Gg: AR+sD13hxPlNUJrO1eae3HLb1/HxwTbfE6jCGihaGHWqC8ub3G5CNu+xS+bFfj2OkOx
 GjPrrcIQ0E09vf31GOdnxkV7XWpeAGJYR5fNIu5AqTScyN/O3y0AAFMicNMNMeCjmNzcZhOQkla
 g3Ce0uyzAlpB6e7E+T4Kv+s//46tmOisfOpHW5au6e1b6rttYTd4xlYTjEN6XcHZd2TkDr4nBJd
 G9UQOTXx0VX+YzJOQt03Zmkf3G/uf/D4h+UG3ICUmVz6lDa73t6930tUmL6bbzHX6zwuaMqbjzc
 dfxzNSx2hJEnHq2KW7CwkTf6qN22zwx1lrgxMi0EIu7g8GYNWUwwxAh4G/IgkXdeAY861o9u7Ah
 yn5Wer2dN1R1kI7Yfxu4EMTfJ6GAh+GnXx30=
X-Received: by 2002:a05:622a:5c13:b0:528:162e:29d3 with SMTP id
 d75a77b69052e-52d73dd2dacmr69317561cf.32.1786632701891; 
 Thu, 13 Aug 2026 07:51:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5c13:b0:528:162e:29d3 with SMTP id
 d75a77b69052e-52d73dd2dacmr69317061cf.32.1786632701407; 
 Thu, 13 Aug 2026 07:51:41 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b1bd61sm67203035e9.8.2026.08.13.07.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 07:51:40 -0700 (PDT)
Message-ID: <e02f8fb8-3ee3-4471-9748-8a26b95134a7@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 16:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Next patches
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260812151444.2611689-1-peterx@redhat.com>
 <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org> <an26zg9zVW-JrV9f@x1.local>
 <an3JcZvNNS8o_UFg@x1.local> <f6f159d5-4740-49b6-949c-cdcb1ec3c71f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <f6f159d5-4740-49b6-949c-cdcb1ec3c71f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mYT1A319wojYOo03SRdPT9aJw1ZCS3I0
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a7dd9fe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Vs8K37Lm-pY0MMZWHV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwNiBTYWx0ZWRfXxrjMQ6J/2356
 QaA6lxcExZus98N7TaWxu6FgaPspQdUtppPI9ngCbola+LXybe8KTD0rkVAXZSLj+PbIIpDHFbR
 DMP/CJnxuG5KbVfojDqVUt0b2pRgGaU=
X-Proofpoint-ORIG-GUID: mYT1A319wojYOo03SRdPT9aJw1ZCS3I0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwNiBTYWx0ZWRfX3EwNVGIVPk2e
 th9ihW3jJ4NWwy93X52xovOP3P2EkpCo2HA3lvmqiNiGyirzF07w20KskNhhK7D89w5YhMIx1Wt
 8u0CngCN2BkxjnNHa+CLRlWgJaqQR3fnRqilp4IoU5HLwUfAoJZIs9KENAG7W3C/7mjAkooUmlB
 5/z7N0m1fyZcoE+PkWd0qskN6HBz8LEVEG4KjiopXRlEI6EdDjRFrEoELQkBSlqXFZO2udyQTiY
 S8N2tXXBRtwcDrw6aFvfXo5Rr1vDjNwYvD9cAuKKlJF8eEFP9Z0KPQUTf++LqhX2SBR7RMw0U+J
 PDPruZNVH/bCl3+piwTak/7onxYoijxLn6NGirM7X+pE5BnxRec/LRQjrdMIS9xfXCFhfvle+1D
 ZkvLV7yepxB+VYQDMmIpTfva6MtHubi613yD1kQ0bg7Wvk06SDEjeCcZzoMv/H0Cxul5UEhk04X
 tJk9vBcQ01uwMiphsug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130106
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

On 13/8/26 16:14, Richard Henderson wrote:
> On 8/13/26 06:41, Peter Xu wrote:
>> Now when I think about it from the root, I tend to like what Xen defines
>> with ram_addr_t:
>>
>> /* address in the RAM (different from a physical address) */
>> #if defined(CONFIG_XEN_BACKEND)
>> typedef uint64_t ram_addr_t;
>> #  define RAM_ADDR_MAX UINT64_MAX
>> #  define RAM_ADDR_FMT "%" PRIx64
>> #else
>> typedef uintptr_t ram_addr_t;
>> #  define RAM_ADDR_MAX UINTPTR_MAX
>> #  define RAM_ADDR_FMT "%" PRIxPTR
>> #endif
>>
>> I don't know how we supported 32bit host emulating anything larger, but
>> logically it's doable, then IIUC uintptr_t won't be enough allocating
>> anything >4G? 
> 
> ram_addr_t != hwaddr or vaddr -- it's just an internal token.
> 
> So a 32-bit machine could put 1G of ram (identified by ram_addr_t) at 8G 
> (hwaddr) just fine.  But obviously it couldn't put 8G of ram anywhere.  :-)
> 
> That said, Xen was weird in that it used to be possible to have an i386 
> qemu command-line talking to a x86_64 dom0 kernel controlling x86_64 
> guests.
> 
> So, yeah, now we should drop this ram_addr_t distinction and always use 
> uint64_t.

🩷🩷🩷 lovely 🩷🩷🩷

