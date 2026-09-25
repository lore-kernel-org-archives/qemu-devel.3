Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF0C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Ic-0001W1-S7; Fri, 25 Sep 2026 11:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xA8IW-0001Uo-5N
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:57:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xA8IT-0006aH-Gp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:57:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDkRQ93628372
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XmjN1Kt6w9l1cbtgTXj9delgN7WQ70k3BhWCpCN6CIM=; b=R2F2zjejM/HRNpFZ
 Xltv6SzIX3vsAECXoKMFlcGRzuy8upfRUTvvKXw+gOMH9xdCyKhkkXhnOd4zOOLE
 H6yuE+Em1QIYZVclRzCpdrlMfbY+DqgI427LGIK6zrzdjaTAytX+rJ9+3P32Ne2Q
 19T0pH8EfmdC9bVY9Aa3Lj6xii/9Xtaczf1U4DSlwT/vuLjC/dulYQG9PhK89KK9
 LLBEFTJt4+7IUfssucZHjR9YqmLqZTU6tRflM8pgQcPBzBsYjhhbYRowsUY2tduY
 v7IKTdEzAxCUI6PHuo3CXKO0a9Y09GEHCp396/2I/ErsyjetsFTJ72BoZQNDYt+F
 t5KVyg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3a3hu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:57:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a0be20102fso759449a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351830; x=1790956630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XmjN1Kt6w9l1cbtgTXj9delgN7WQ70k3BhWCpCN6CIM=;
 b=iuCjV9ZK53+gFuhpfWFmjWjtJYVap0L2VPcMTSkFB0PhZtFOQuIIMgUcdekq0HM8BH
 D9fJX6MemuTEGnXqAtsWYNzmB9AxTPWc2V3kD5QFzMNsaPB7wAbo7j7OCuTmTl+bjET1
 RCM8jCivnbeySa7f6HLEc3xv0ofqcMqd6xJIkXP+MjPBQepT62rRvN1hhnwcpmuNnJdf
 bK7NGC5ePY935uMq8KvBsNFyi3dV4cUgY80SGzXWdsrGxcgiY5ZKbkeOveW6cERVa0mO
 ly71vTenyRpQUQ8HpK7ozCRiJrrfGvZDB4ZkykfHwzj/I8xjadRHH/genc3tCE50QPvo
 D+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351830; x=1790956630;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XmjN1Kt6w9l1cbtgTXj9delgN7WQ70k3BhWCpCN6CIM=;
 b=XKNSTVlUWWk2M4VJsHhMXUIIdUm/mNWdYsMtkqzi2BAKCF7Nw3jBfGL4Rue+XNPqlC
 nXPhSs8jceifVDjDyj/WkNLQfjOVDvByLy+/HJ49rYg5VrdAxECHSQuSSNGG8O/HbDZa
 JtbgGli6N18QmKFv2PrRPkpWcl0QpZuxIiyyDeHeD7vC/TNyIxfDdeyw1jmVu6Cw2WRo
 41jo6883ZffrxHVdgftPiktWug0P5J+o2HIxPZlktajQe0EVKhrcFLq9nV91cOI2sGTj
 jy+DMXi0irobCmBJnQnkrLqbp2yYNayKdfndKVXOziF+VH1UrHdBm3tWwZT4nWwWEKTn
 aHVA==
X-Gm-Message-State: AFuF++lLf99xy3Z9aNgAzNb759DApRXURF/31AcFl+AvBsQ0vmo5/A6p
 hFhJeJ8Rd97laxDZx7jk6lMTAnxUXRLafxJZNkfoqWdk2YExjYvwUmYcEGRjR6FrtNXDdyaNKL4
 EI4UF7wBK8sxiZrKp8RKZg5M07/0nVkzLdil3VjYKlqu3AVHAdbZ5mNF/pQ==
X-Gm-Gg: AYBFou1sTp7RcsQYI7TJmN+pXawADiaf9UHQvRj0rQsSlMeuc4ziOdFDwRDfMEQF5L+
 vZzLAJIex2F24J2zhrJIG4QfFyE0LTcRsuWet6k/G4B4VUjENaOTu3Q6ite50YUfiX9KZQ2JLKd
 MBRUJOp+lyi5pdinbKv/W3fHCBcjhWK/kHtVs6+hDY5hoa0xpFtD11/7UtcWacX+lxQ923GoXX+
 +/vXlVhYJ2xpeTgSmxhoO7g2l/VZ7XMqrsCxwzsUq3nMyDJWl1BM0eOlL7KtWoMx7ovfuk4f9jj
 BdhqFpZE53dr/ZSLUnNLl7sMBGHmX5TILA91Mfg7j/vwwIZGglM6lcqLWSMQ7jbCxe/dxQJfmlj
 4svh72Bbyo7ncNRs590jkApFI1xuNF8Sq+WarWp+4HyGgwWj7aWn438GDmiLliAIBvVY=
X-Received: by 2002:a17:90b:448f:b0:3a0:bddd:5b0 with SMTP id
 98e67ed59e1d1-3a0bddd07a2mr1834074a91.38.1790351830169; 
 Fri, 25 Sep 2026 08:57:10 -0700 (PDT)
X-Received: by 2002:a17:90b:448f:b0:3a0:bddd:5b0 with SMTP id
 98e67ed59e1d1-3a0bddd07a2mr1834049a91.38.1790351829655; 
 Fri, 25 Sep 2026 08:57:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0ca127237sm1014251a91.4.2026.09.25.08.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 08:57:09 -0700 (PDT)
Message-ID: <3e61ce09-b929-4716-95ab-84bf01bef497@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 08:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/tcg: add alternative cross-compilers for fedora
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com>
 <arZBqmDtOX8YoJaA@redhat.com>
 <fa2f6396-c658-4ca9-a985-04d9f2cffda2@oss.qualcomm.com>
 <araZTzyeRXP2AL80@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <araZTzyeRXP2AL80@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX1jqWCGUlyLLt
 PHtAnTkxPz6rAlwRAuLzvsU84iM178Mn4c8RHnlOmTkyIqFUgpMjg/nGbNlfV92U18GBMYduTD+
 C3MfXv7t62zat+ZJDjVYFr+r38EvYKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX0rhfLiJl91Oa
 In3k+NSjxnRRNiEBofm0laGlQ3iooXzSAtSfGwoyiA/UD28yYzAjnwJY3IITpQrAeYiLUwfCHeZ
 LI+Knhi6rKb+s3AaQP6y0/kjSPcvn5bi0HWp63V8xcLpOgYKjG0lTiizb9wYOvtA4HhomtnpbGa
 +34XH0i0vn/lAQs22OO+Lj702Cot+5+RUv9c4pcpa2IBwRC2c4MmeNGC/HzoPAubr8YlfB8ITpf
 q8+5diN33bdbzZSaT1k9cxgwGMJxsSTrVb1ZKbF/E4qzgSSkkGeSZOEG7xjDmyyDH4ZMBaq/5P2
 BkX4QOdIfKrGTX4wQDOQifzsrVMdIrUGc/iA2EJnriBAUVnEcKP/TGBqjv0YP9eec6zU/QbQ5xm
 i17wNjJziBQTW/k8ESNwkqdtEN2S1H5YiRXBeCt2YQnSXdTKeWXVnJ/086yZ0Wzu5keMrQOS/rj
 pI6S7Budnhq1lSraxxQ==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab699d7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=vTr9H3xdAAAA:8 a=kgWxgcjZCBJ_TQAtSwwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Yy7wr870skKO7kM8BRzFrvF1kFZGZ6ny
X-Proofpoint-ORIG-GUID: Yy7wr870skKO7kM8BRzFrvF1kFZGZ6ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/25/2026 8:54 AM, Daniel P. Berrangé wrote:
> On Fri, Sep 25, 2026 at 08:20:44AM -0700, Pierrick Bouvier wrote:
>> On 9/25/2026 2:40 AM, Daniel P. Berrangé wrote:
>>> On Thu, Sep 24, 2026 at 09:39:41PM +0000, Pierrick Bouvier wrote:
>>>> This allows to pick host compiler automatically on fedora, as those
>>>> binaries are installed with 'gcc' package.
>>>>
>>>> This covers all host arch supported to this day:
>>>> https://fedoraproject.org/wiki/Architectures
>>>> - x86_64
>>>> - aarch64
>>>> - ppc64le
>>>> - riscv64
>>>> - s390x
>>>> Note: QEMU and Fedora don't support 32-bit hosts anymore.
>>>
>>> Regardless of what installation arches Fedora targets, it
>>> ships cross compilers for pretty much everything. In F44
>>> I see the following GCC available:
>>>
>>> gcc-aarch64-linux-gnu.x86_64         16.2.1-1.fc44 updates
>>> gcc-alpha-linux-gnu.x86_64           16.2.1-1.fc44 updates
>>> gcc-arc-linux-gnu.x86_64             16.2.1-1.fc44 updates
>>> gcc-arm-linux-gnu.x86_64             16.2.1-1.fc44 updates
>>> gcc-avr32-linux-gnu.x86_64           16.2.1-1.fc44 updates
>>> gcc-bfin-linux-gnu.x86_64            16.2.1-1.fc44 updates
>>> gcc-c6x-linux-gnu.x86_64             16.2.1-1.fc44 updates
>>> gcc-frv-linux-gnu.x86_64             16.2.1-1.fc44 updates
>>> gcc-h8300-linux-gnu.x86_64           16.2.1-1.fc44 updates
>>> gcc-hppa-linux-gnu.x86_64            16.2.1-1.fc44 updates
>>> gcc-hppa64-linux-gnu.x86_64          16.2.1-1.fc44 updates
>>> gcc-ia64-linux-gnu.x86_64            16.2.1-1.fc44 updates
>>> gcc-loongarch64-linux-gnu.x86_64     16.2.1-1.fc44 updates
>>> gcc-m68k-linux-gnu.x86_64            16.2.1-1.fc44 updates
>>> gcc-microblaze-linux-gnu.x86_64      16.2.1-1.fc44 updates
>>> gcc-mips64-linux-gnu.x86_64          16.2.1-1.fc44 updates
>>> gcc-mn10300-linux-gnu.x86_64         16.2.1-1.fc44 updates
>>> gcc-openrisc-linux-gnu.x86_64        16.2.1-1.fc44 updates
>>> gcc-powerpc64-linux-gnu.x86_64       16.2.1-1.fc44 updates
>>> gcc-powerpc64le-linux-gnu.x86_64     16.2.1-1.fc44 updates
>>> gcc-ppc64-linux-gnu.x86_64           16.2.1-1.fc44 updates
>>> gcc-ppc64le-linux-gnu.x86_64         16.2.1-1.fc44 updates
>>> gcc-riscv32-linux-gnu.x86_64         16.2.1-1.fc44 updates
>>> gcc-riscv64-linux-gnu.x86_64         16.2.1-1.fc44 updates
>>> gcc-s390x-linux-gnu.x86_64           16.2.1-1.fc44 updates
>>> gcc-sparc64-linux-gnu.x86_64         16.2.1-1.fc44 updates
>>> gcc-x86_64-linux-gnu.x86_64          16.2.1-1.fc44 updates
>>> gcc-xtensa-linux-gnu.x86_64          16.2.1-1.fc44 updates
>>>
>>>
>>
>> We want to detect host compiler here (redhat-* variants), as mentioned
>> in commit description. It addresses original request from Paolo. Cross
>> compilers above are already detected with current cc field.
> 
> Oh, I see what you mean. Itis dealing with the naming difference
> between  'redhat-linux-gnu' and just 'linux-gnu' in the compilers
> for the native vs cross arch RPMs.
>

Right.
I'm not super familiar with Fedora, is there any fundamental difference
between this toolchain and linux-gnu variant, in terms of ABI or
anything else? Or is it just a distinction for "Our toolchain with
additional patches" vs upstream one?

I tried to find some info, but didn't really find anything useful.

> 
> With regards,
> Daniel


