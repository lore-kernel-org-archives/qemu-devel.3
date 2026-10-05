Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E529ECA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnAY-0006vq-Ja; Mon, 05 Oct 2026 14:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnAJ-0006tf-SQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:11:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnAI-0001lE-2u
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:11:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLdFd3043993
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ng9WySV14TSTJCdCCvPSLLU2VEH+VQ0K8UfvW7I5bUI=; b=j1oG/+iHH1XeI8A4
 CgY+2x96pSooi3SwZgXfG4AqZ5/+aBpaFno5TX97u4gWuNU9jlQuMtiimk8nAzqK
 b4ZnhjBEp2q0CbkERuZ4jO1CMv0OOht6+layjQ1o2+ju3taqSRv+G49UyEd7CZRE
 utg4pHtpcQO3DrIEg19u3VqyXBH+yyJI3t6F4qzpv8AEXMCv+4tukYyI9ncWX67e
 Lu529NyxXrKFNZUehsRjYvnJrHqbZP97ALKKKqH5ISxerDPSXeOgkXHod3ntkoA5
 9ARBMpLKMbahwGD79iNqQFkAx+EbqSs5dJHsBv1rBZIY/73s1bqBJQADk1m/kDCf
 igxUxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvss1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:11:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d80ca2184so2719622eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791223911; x=1791828711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ng9WySV14TSTJCdCCvPSLLU2VEH+VQ0K8UfvW7I5bUI=;
 b=aXHE0jrleW8e9M0VlC4cTKVbyYCiVxJXDLhcFi0TQfK+1mnkYC+lfHrNMuXQmfSLwr
 rCgQebIACaHYOsnr4+FwNLWundO3BnlBdRMiKKpKfK5uyKJV0auaRVvV1QjAtiJhTr8H
 dSije2qMu9r8sSLPH6fERtxs7DVB8jmZnnLCqOh42aozL7rHYvn4xBIDRgwoom7LlPec
 trnbo6g9wcUezltf+/pm+STV3L3Owcc7jgy01axmU2n7NvBG1AgNNqCHM5en59XbSMVi
 x9NlvsnEXZ2NjVgUMizqMzsA6tW5x4DLZ9f5ctRHi88TMw/usaBsw2DGeNpL/8rFF7Kj
 pG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791223911; x=1791828711;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ng9WySV14TSTJCdCCvPSLLU2VEH+VQ0K8UfvW7I5bUI=;
 b=W86TCvbno1lKR2AEISozBuA7yfrXgOSZJkPmKo/JinAm4DPZgNYdi91bvAwXqS1Kte
 y99Ym5am+C/WbdBf74qNtPabXvjrZb91kJ8Ul60PEUCrD7sflUPaTtYEwSREA87PsZup
 e12R0RBGqYdHu5g3+jDG7kIIe3hTsiudzWHYdAxMjeegYCFXN7+HbyCxm5kLV+UEOj50
 exzIEUs2sr4Qj7NFlnkmstNI+OpYcKtWV+cBCrSLZ6APvmvYr0jJ1l3IjW19zH9soocL
 YSDc5D8DtZuaopbBtUOzIsUI38+q4xNzA8xF3o5o2goiEWQoZpZZHTgcbmt4XXoJRnIN
 f1hw==
X-Gm-Message-State: AFq9FYLTscDWQhIhoPplnDZHYpO7ObaWAFGPhOvQ8M/Xl30eRHPVWe7s
 bOwnpazzgKu23Uq1bD8OMZRFb6iLp2t/9AcxwYS+hqHDlMcwXPgSecg60rO/Zw3HE/+Iu6IAQik
 YDEYzzYYnlYO9xnsKRd8f7Q0LG95Caf0B4/TuQad3eqw3wIZHnWz0MJcchg==
X-Gm-Gg: AYBFou2UZQfs8rdkXQi88v2qADj+oIohBzD3A00d7saCJMLd8QPXq7mlyGTMpFdF/kM
 5FImPB+9yvGgR2xw4/xVkaTM0adzQOIjFm7hbxn/ste9NCaRh9J05XTk1yt4qHqm5BvOz2kkPX2
 PR+QyP7A/bFFFVCnRA6MqyzMlej2IEqCl8+v9SnQI5m5i15NjhcctPRGn246MzcHndcgDklGf+n
 rRMwoPhMlhFHdyyI8c0YsZZr78beVbavYhKgjxi4446ehglu4E081SXR1gFMnwNI2oaz47EXQvD
 rz6A2MV2h58wGiLpflu7uTiOkfWb0cOvXosD2TTUvFq7R0JS6/oc6wGYtIFvhZr0/MaMTAQMe/f
 6C3ddncvWzM/92x04828vVZcLrYE1xVav09tdMmyEkgfy/Qbi694ZStoErgwkVGTW5bzbZA==
X-Received: by 2002:a05:693c:881a:10b0:351:2a3a:7e7c with SMTP id
 5a478bee46e88-3512a3a8632mr5713613eec.34.1791223911078; 
 Mon, 05 Oct 2026 11:11:51 -0700 (PDT)
X-Received: by 2002:a05:693c:881a:10b0:351:2a3a:7e7c with SMTP id
 5a478bee46e88-3512a3a8632mr5713561eec.34.1791223910400; 
 Mon, 05 Oct 2026 11:11:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146b3b5aesm101719eec.29.2026.10.05.11.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 11:11:49 -0700 (PDT)
Message-ID: <00f04444-18ca-4881-a0e9-a0dfac654e35@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 11:11:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/21] target/microblaze: prefix helper conflicting
 with other arch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
 <20260930020108.217892-5-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_XCgvZLZL8xpRcyw9b_vNXA3w8fmnbd0X4q_-8wjtoxw@mail.gmail.com>
 <80ced4bc-202b-4223-866f-62a68edff48f@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <80ced4bc-202b-4223-866f-62a68edff48f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3e868 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=OmRjonFGwHG3DbjuugIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: P4vRU2qNfx9BrmifBjrukWDpL3PSmOXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX1FpN1wxqqONx
 Tx2V5ZbkxhHrcpgfaNra0ru0KRmxso3wy9085gzKoeowHKy3QzI5lRsLfCJC2OgjE5jduUrRXPG
 5w9qCjxQaUQcVq2oaJkADFdSwXrL8tvbOvZlPPonLJth9U2NCbg4vil12Ikmk+Yro4m4mdgp25l
 C/FLmL9C1oOmNIPUl32zhgPxNasEbwBJMDvTnsvhx5dmswsN/IhSy7jrnpY8jLGVW4A5qTAXFXg
 M/k9feYgRX+ADWSJ+GYQO5KTzwiHhzbyRRZq9leJU5PrK4NmeYVHzzO7y7k8zbQRjlLMNtQA+Ij
 Ez7NHoejpxG8I8zLwMRtW/47A7XjglMuoI85zJ8EEfruGJZOij2vax0tp2TIn7rk+uK8UtZzfEu
 CkoeQCmNF9JCsGjk/kcO4TPBuVl4k7kdoFTRXG/bE1BeZNMYAzT3MJhKoetogLrqDZ5jki/aJTZ
 BmMBnvwbbCe4E4RwuNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX/mwAB3uGIDPl
 mh/ud6rzzqvetKMlqdimrxFMRz1JF7D+6DEC67AIKjdcps+nIV4LhXWthZdOfkYS+eSUe3ONo8/
 qSDa5hjRcBm/SeODJ9rReIVhw1uuk64=
X-Proofpoint-ORIG-GUID: P4vRU2qNfx9BrmifBjrukWDpL3PSmOXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050071
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

On 10/1/2026 8:53 AM, Philippe Mathieu-Daudé wrote:
> On 1/10/26 13:41, Yonggang Luo wrote:
>> Hi Pierrick
>> I have prepared:
>>
>> Subject: [PATCH v2 4/6] tcg: namespace target helper symbols for
>> combined builds
>> at
>> https://lore.kernel.org/qemu-devel/20260930073935.712-5-
>> luoyonggang@gmail.com/
>>
>> to deal with these issues in a generic way.
> 
> Thanks for proposing a generic way to rename helpers! Let's see
> what Richard (the maintainer of this area) think about it first.
> 

As there was no answer to this patch, I'll move forward with current
series and sent it as PR. In case we introduce such a generic helper
change, it should be trivial to revert rename patches.

Regards,
Pierrick

