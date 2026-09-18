Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75C8C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Tym-0008DG-BQ; Fri, 18 Sep 2026 04:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7Tyg-0008D4-Lb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:29:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7Tye-0004EC-Ja
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:29:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I5xtlf3423148
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U4rAb17vhaFJg9aICywRdIpGE3Ic5QhrZwMqptFP4iI=; b=VgXmQ3hGnBv3+M2t
 a9t2QHQaJ3ZPqgU1USkzdXh0zbzxxfSmzXCz94S50r5wxPPenXb6k1PvMgOB+xg5
 xNKvljIUnN2YEuVOihys+R7Nap+u5nj1GX0uLBg+02bx3MPaq7Hz2/2IHhWc6WPh
 0ObbJt5sX8vB4yRbV9rqf2Yl4dxs0oX5FX9HkchmxtFt+nCCTFtJr/pM70p+Kr3E
 S/9/DW6rx1NIbdHtA33rKwdflk0bBtUFowDKdIRLjktySzgDQ25xmnAcJBV5FuFc
 xckfvUmFYVliaAC4vPLWYWpUHxbKkN8VHg6/SlCJjI9YyftyD1oDFHZyxwIAcl2P
 b08Blw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrjdt6m8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:29:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so663902a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789720185; x=1790324985; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U4rAb17vhaFJg9aICywRdIpGE3Ic5QhrZwMqptFP4iI=;
 b=WlO9hIu9lenENLCgRMp0weCJtzua9JBHyUt9pBR/tj06uXN+XSzh1rci2dwqWaAbcj
 vkv2U74Jo3eEnsqT8xSLAl48w5q5GAk7ESJUwCui1jhjO5gnrAHuf5oOULOOQa8BRGDT
 v3X3LXivUjEtOPNQGOWUoJRhvj0fLsDotfAtjZ0JoLbVm18/DjkCASXLT1dvW9YFAC4V
 TV2j0Z1F5VNNWaCIjyaWIJGm7DM6TVDV9MhkvkpKWhDwk8Ro0/4ordPyVdEnqrQZ2CDx
 jj9v95uGkvUgjHqV2FzsxfWVrFYQUlAUN5bOtj36ryqr4UWrAS+TICNFkDvRS1DEjVFP
 ICDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720185; x=1790324985;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4rAb17vhaFJg9aICywRdIpGE3Ic5QhrZwMqptFP4iI=;
 b=hTCERV58QeY1jyZ8NZ2cXUY8Ye220co2xz5+/AzjPf75F+DN4mzR8eozif5oqCrs8V
 5+RDL/m1+FyCUA5CuphsQXg/BWHRGLlV/j4GRC1asFfqwyB2Kkng86f9u8pwYuPr/fhs
 pQordJz7wD+JE5I0pt1SJB3BQYrE017Mc18vwGCMxP5PSDc1DBGmYlvOLTuU7nFhF1SC
 THPbxk+jxMdcAnyrqXkG5f8+EEY6SO+5g7MGiXZmPuGxncYmsk+xKuEmBD7/Y4eF4AXv
 F0f70hfGzT/YkuQYU0Bq/0oFUbL0LeW7fzH/bocWbBPiZz8fCeTJtV7xKk9A6726vQRV
 /26A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5FxTUN9tai1NZVBU6pv5I0qhVvAgTmxtjG+Pkdbiiit0dxSaf+QpYYsGd/WbcsW3wgsF4z0pgysNq@nongnu.org
X-Gm-Message-State: AFuF++kBRYCupsC1+cTjReXDZ1B9S2LRyJSRph9d4eo3laMfpIZrLnLO
 uSgV33jmm71WpEzwJz50zFarHj2/1j0bcQOys7iX+0xvweIzv+3DuxlmaLlVRo2P+sp7pHQcnvu
 iEI4ZEdVs5FdfJQFRQg5eoGBvDUYA1Z2EPQDB4ndAJYDLF9Xvbk5dBDCPDQ==
X-Gm-Gg: AYBFou0pJmcLJJ9mbGXt9B0EANw0XFwoL3MfBJ+0VlVfmZ461jtrLp0vT92Kvo4Esum
 j1wLzCTvy/nNpSXipmL1MbtYSOxfwEVR8zbuJ2/2/cH2OC18wp1mib2bgp1zA4Dilta585o3lIP
 lgeo7oQLR9IHyQ/zjhCmL6W9Y6S3BoDu92g1k4Uu6zxZTPptE/+JT54g1GeJW+L4GhykHZLaeP9
 znwd5aEdmnqbhWmNeUtweuhsily0QkvNfR1vUB36zbYGZxr5g3ctiCF+rENFe8/KusLbbo9kn0W
 qkopDH4AdEZeBAvfw6tFUsQAQVhFYCKBSbeJUjmJDjoyEmuFXfT4BjatiTIln0F6WC9r9vy3+BD
 6mAg+OC5c/mi+1xPDemMvrYy8W54emWlwGaQxPmVweBCeWEJlmh9clNUqzsrqKgGVXkNI
X-Received: by 2002:a05:6a21:6e4c:b0:3d3:adad:f177 with SMTP id
 adf61e73a8af0-3dd8c53aa38mr3431683637.25.1789720185393; 
 Fri, 18 Sep 2026 01:29:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e4c:b0:3d3:adad:f177 with SMTP id
 adf61e73a8af0-3dd8c53aa38mr3431635637.25.1789720184911; 
 Fri, 18 Sep 2026 01:29:44 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c2d27042csm377434eec.7.2026.09.18.01.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 01:29:43 -0700 (PDT)
Message-ID: <b173e4e5-6efe-423d-b4c5-2aeb55cab976@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 01:29:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNiBTYWx0ZWRfX4VP0HWmua9Ei
 PL/IAmmb5tawtU0EL/JUA1Yn5B9QI5UcBdqbnuqqf+jrvfXEOvIDGc4nAD90jAvAIZufyDLgOjz
 6oHyV/jRNVBg9Pft0aMB6jkuzYeMI51BVJwUwzCJmeOujgkxPXjxln5s4Y3jFuYyt5wwlwT+ttd
 3Jh/QmU+nKuTIy6PHEJKW0b4RpnVy+4zAuFXzpm7oy483eG4x09pCKw/YneU3rtb2kiOqH+EvyH
 J59k9UjdQQXWNb2nnnwW7kpIlb5xJKTpmhSroCGaWBdXwbhiTLwFbA/xB83l7vGoZZJf9S5YJFC
 UuI9nXNZx9y5CrDON2rdQUkLjMz0Srfz53JUimCV3Hp1aoQJfnbbQc3g6XQ58ShwDNgVzfeOzd5
 /dgZO9/lycJnzlu5XmGYQBIhN5/Y91oYKAacvviOITcgA0PCaHWn0wV2aQsHjBMfhqRVIhniK4l
 swFwEOJWgNt6/XWp5zw==
X-Proofpoint-ORIG-GUID: mulOBeCq2FN3gsbAPPvDZrz9rYJnzgd3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNiBTYWx0ZWRfX5ERClFMz0AAA
 86aWaPF/n+TE9n0PmVku9fUCuwfmLwcZlJqMcFkPVwHFGBh5QFqMx+dJqiz9A26CK1UXLllfA8V
 EXeGLGkTYkSBMtV8TzPwSLLQa3g5fvY=
X-Authority-Analysis: v=2.4 cv=J9Q/fwnS c=1 sm=1 tr=0 ts=6aacf67a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=afHRBKGQeyHntfYOPjoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: mulOBeCq2FN3gsbAPPvDZrz9rYJnzgd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/18/2026 1:05 AM, Pierrick Bouvier wrote:
> On 9/18/2026 12:30 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> On 9/17/2026 3:18 PM, Richard Henderson wrote:
>>>> On 9/17/26 12:00, Pierrick Bouvier wrote:
>>>>> On 9/17/2026 2:49 PM, Alex Bennée wrote:
>>>>>> how much time? it flies past when I run a rebuild.
>>>>>>
>>>>>
>>>>> For a no-op tcg-tests build (i.e. with tests already built):
>>>>>
>>>>> - With current patch:
>>>>> time ninja -C tcg-tests
>>>>> ...
>>>>> verbose pull and build
>>>>> 320 lines of output
>>>>> ...
>>>>> real    0m15.817s
>>>>> user    0m1.342s
>>>>> sys     0m0.840s
>>
>>   ✗  time ninja
>>   [1/114] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
>>
>>   ________________________________________________________
>>   Executed in  515.16 millis    fish           external
>>      usr time  433.82 millis  968.00 micros  432.85 millis
>>      sys time   86.05 millis  253.00 micros   85.80 millis
>>
>> Not sure whats going on there then. The whole tcg suite completes in
>> under a minute (and would be shorter if i386-linux-user-test-i386-fprem
>> and riscv64-softmmu-plugin-discons-with-interruptedmemory where in the
>> thorough test suite).
>>
> 
> You need to run "ninja tcg-tests" explicitly, as tests (and images) are
> not built by default.
>

To give a final insight before bed time and the PR, the current "magic"
caching implemented in docker.py is simply computing a hash of
dockerfile content, and if a matching image exists (i.e. with a label
having this hash), it skips the build. Please note that ninja will
always call docker.py build, and the trick is that docker.py selectively
skips it.

That's a common and safe optimization for containers which don't have
external context (varying build-arg or imported files with ADD/COPY).

The current series is ready (ideally, with additional
20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com) and PR can be
sent to share the fixes with everyone. It solves all problems that have
been reported.

Let's drop the current patch, and you can take a look at it later to
convince yourself it should not be removed.

Regards,
Pierrick

