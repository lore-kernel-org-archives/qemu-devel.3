Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB0BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJ70-0002M3-OB; Mon, 13 Jul 2026 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjJ6W-0002CQ-Gx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:02:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjJ6U-000532-4j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:02:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF85WY1887762
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QaDCy/qGhgdFsIDajvawO0hK1bDj9PIQxqghEF9qMdk=; b=V2kJLBqL72Ph00DH
 dpFMH5H6yaif8LS0MKinw/7+QO+W5AmdAsOVG+IYHIes3M53XQN0dnka9xIbFFYi
 6mhKw5/3NbnaYwzTljadd5RzdunMGi8di024LQhQ3RPonLTl4ZysxL05qxh6OYzY
 jtzKT861zwZFwElFBxrqeF+mfbKVArpPUhjSTXM4PyGuVRxCQGRsiF0mmKsr9ib/
 EYB+XG4RLFWa+6j0fTsNMLbzygDpV5OY/Se22xRBQ8HFaOAQD55h6cF5xptPjyQZ
 lXqX9/iMoNISNHX/f3pQtZTTtEgfFzr5rYhM4r1EnTqo6kk6xony/W0+75xrWsDW
 Dg+ekA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavskse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:01:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so8493935a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783958515; x=1784563315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QaDCy/qGhgdFsIDajvawO0hK1bDj9PIQxqghEF9qMdk=;
 b=a42/tmlLSQZxqtqShaKueipYT73StLkjhDFVYmrwc1DFaKhRy+tuj5A6Pf1Qzsm8+7
 B6vFyOggvGe8vo6r0D8m7JFXJpu0akYhZ3AH1C+qp+VafTkD24j9AAvNO39vrHfdAtex
 aC+7wBK/QhwRiY98LBDvcMXvZ3cX4HDcQq8jBG1BtMgVjdkfS5OYTSvZCjgayATtjDvw
 2pX+X/0WbtqY8cXTp/9zhteSOhmeIUzJaX9qTf0dyDvUBUPwHG2tfb9K1fe/qFiNuEep
 FdhsNMGTZeOZrLV9uCZlKqwiU9xBsqG3ubkG1evW1AyhlDMp5stPqPafLlYjauWIhhTI
 DJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958515; x=1784563315;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QaDCy/qGhgdFsIDajvawO0hK1bDj9PIQxqghEF9qMdk=;
 b=CDCWcNg+nKWhGyFqYOps14usc/wsZwUVaV+Xdl+M69oi6Hy+00ChhoFjpn9ZZEM/Ah
 oApmG7rToUC9GCk6kV9/rqX5XnlqJoLaSfcoHvap01vsFWcQng7iy95BVo8ijdmSUxek
 FvcnXUFUDymtqyrO0V8M6d3SojMfGIwPf1TDUtx9aX6JYTWdK7J0AAGMV+iC6arIFyhO
 6VozArYbb66LN5Xa2bqeXTFRNjOrryKkvmcaHoCeI3ZksJn/6YNFImyODJ5ikHOyyUWf
 CdSQdPxrsft31NluAIQ65LBdb68XP7sU1DHKHJzUxswam50I3ZItBN5uNAkNd22w61m3
 vyZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBdryLLdj0X12+7MWCjd0vrvrrvQkl0dOD9Wb3yVZKN6magSblTvwM0IIOrSZ7hrK3u4dMqAxur26D@nongnu.org
X-Gm-Message-State: AOJu0YyG7wyOW75vLQ2iweU/higHzVJ2+zfPKaqxMSCeiYumhELDQEt4
 Zu4Ozuuzqvc5aCT78vIi5L4897NAR5NKANDpLjsuGLPLno6VMWT5XttltYvTx43Rrk2YOVfdkgq
 /hxy8LHmPmMx5eV1mKYDNosawT3PxMVZr/GsWd89JZNMDZtZAWbjK0kW9bq9/cEA6jA==
X-Gm-Gg: AfdE7cmdYi4L/r75ntvnqBXS86G1ZSR2rcb89ngPrykUW0iZjsLK2lvxyfu6yG0pNoI
 ZHQQXdAKzc9btZ6jzi3M3KX/2kH2WcDSJEfctYHNazmgYdLWmUmlTtykBtT7EBuKVnQYs9XepX7
 e1Nx8ngpMxVyIecJQgI+b+DnHZUg2Q7BFVy2830ujswafQmdulzSEcPTqEYqkDUnZdhAVhl7/k9
 h5eDNNjVEMX5J3CkBwKPpsM7Auq6t93v9Ijud9HnTDjrANY+PFBZuQxqsCSbIGhZ9LDoLh5ycHr
 ppFsDNtEbbjewP3VOxbxsqVHd3aGlcthK+2NN2ls25uOEj99lzHWNEPVseWi6+XMYUcm4yvXhjO
 QbkTIKO71mrqY8oPP8zVnC8+qcNOlpS9mnCR27bxRsll50GaxB4Pqab1CuLM5guZxMbGNUe4jxl
 6FU08=
X-Received: by 2002:a05:6a20:d49a:b0:3bf:6c08:fba2 with SMTP id
 adf61e73a8af0-3c110ba295dmr11101419637.54.1783958515312; 
 Mon, 13 Jul 2026 09:01:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:d49a:b0:3bf:6c08:fba2 with SMTP id
 adf61e73a8af0-3c110ba295dmr11101357637.54.1783958514781; 
 Mon, 13 Jul 2026 09:01:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b87b92b27sm29397321c88.6.2026.07.13.09.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 09:01:54 -0700 (PDT)
Message-ID: <8f547a1d-a20a-4de5-8a61-b3e3967c755c@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:01:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
 <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
 <ak_IsMGkkMY8wERc@redhat.com>
 <947a4843-34ae-43f7-8fbc-80109bc0c077@oss.qualcomm.com>
 <alCoHiXzBAcwnOxJ@redhat.com> <87ldbjqd67.fsf@draig.linaro.org>
 <alDdCh7zfJvdD0tn@redhat.com>
 <2bbe43b8-2654-40f3-ac7f-c68ab6ebdcce@oss.qualcomm.com>
 <alSf7zSuHok2RKqp@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <alSf7zSuHok2RKqp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UVvMzjYdqNNs69ZZeZzusm_MABwSV5X0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2NiBTYWx0ZWRfX7KzM8XsJtO63
 m5Bs2EhYCgPtbg3R55boHSE5PmMh8moajDWLTqKpwIO7MrfuQ0YQcsUl39sIH2HybRayovGEqlf
 w8AUenHu6spzxhmKWfjORmAambymOpgvLGBch3egAlLDLfrOTtMiQggXE86efS7UBv0vwN1Umg5
 cpc8Dr7KCEvfJ3PWzp3Q1AolHGYs+6dO5+YcfwYxQnynhZ3mtjm3dA0aMiUr+AMFKV1nKCYtQKH
 88oKAdjL6RIv02hxvTT38y3zkmbfb0j8cmXn5A6qDTPE6dtfLOahRQZApjBCn+X7pzn8onXMsHP
 0hSVwoVehBVhiWBQVtspvE91l13BECsUwLHamX5medVDCdCMEJFr3kKXxkDYc7pBqxxRsQrH/9e
 R2i+4KiqrsjQaSvujuckTRkA6XDyA3sknPvzras5KhmKNUALU+3MaDDpFBM/1dB7kd0oktMhTDk
 Ggj0DT+ja/Nx7IpdpDg==
X-Proofpoint-ORIG-GUID: UVvMzjYdqNNs69ZZeZzusm_MABwSV5X0
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a550bf4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=6LfTF1G-ki2SUvDdRMIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2NiBTYWx0ZWRfX6LpeS16948QE
 /th5oaNUBao2OBBBxA2Yp/QhbP+jXDxhS6Da9FqlvtBMRZSa178cUsy1cxCJE6gUszevZV4bifO
 nnYLmtXkyZ4abls5ZOU3bHVLlMJVP3k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130166
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

On 7/13/2026 1:32 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 10, 2026 at 11:20:37AM -0700, Pierrick Bouvier wrote:
>> On 7/10/2026 4:52 AM, Daniel P. Berrangé wrote:
>>> On Fri, Jul 10, 2026 at 12:47:28PM +0100, Alex Bennée wrote:
>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>>
>>>> (added Edgar for Microblaze)
>>>>
>>>>> On Thu, Jul 09, 2026 at 09:24:12AM -0700, Pierrick Bouvier wrote:
>>>>>> On 7/9/2026 9:13 AM, Daniel P. Berrangé wrote:
>>>>>>> On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
>>>>>>>> On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
>>>>>>>>> When a developer's environment is already within a podman container it
>>>>>>>>> is not possible to use 'podman' again to create containers. It will
>>>>>>>>> usually result in wierd errors such as:
>>>>>>>>>
>>>>>>>>>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
>>>>>>>>>
>>>>>>>>> Podman offers the ability to talk to a daemon outside the container,
>>>>>>>>> however, which could be leveraged by QEMU.
>>>>>>>>>
>>>> <snip>
>>>>>>>> Taking a look at why tcg tests are slow to compile, I reached this
>>>>>>>> commit. It seems like that calling 'podman info' is 5 to 10 times slower
>>>>>>>> than calling 'podman version'.
>>>>>>>> Thus, a container run now takes +1s when it was 0.2 before.
>>>>>>>
>>>>>>> Hmmm, but we call 'docker.py probe' in configure and cache the result,
>>>>>>> so that probe should only be done once.  0.2 vs 1s is just noise in
>>>>>>> the context of configure.
>>>>>>>
>>>>>>> That you're seeing any negative effects suggests that we've got
>>>>>>> something not using the cached probe result, which we should fix.
>>>>>>>
>>>>>>
>>>>>> Not really, docker.py --engine X still calls X info.
>>>>>>
>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L675
>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L78
>>>>>>
>>>>>> Maybe the fix is to remove the check if user specified an explicit
>>>>>> engine. But in this case, there is a problem with podman-remote not
>>>>>> being detected anymore.
>>>>>>
>>>>>> We can fix this by introducing engine=podman-remote, and skip the check
>>>>>> if engine is explicitly set.
>>>>>> What do you think?
>>>>>
>>>>> Urgh, so i see now we have two code paths / make variables
>>>>>
>>>>>   RUNC=podman --remote
>>>>>   CONTAINER_ENGINE=auto
>>>>>
>>>>> Sometimes we'll invoke docker.py --engine $(CONTAINER_ENGINE)
>>>>> and sometimes we'll directly invoke $(RUNC).
>>>>
>>>> Yeah that could do with cleaning up. I suspect the only places we
>>>> actually still need the script is where we are doing binfmt_misc enabled
>>>> containers unless there is a way to emulate the copying of qemu into the
>>>> container with a plain call? Maybe all the systems now have the
>>>> persistent flags which would skip this.
>>>
>>> Yeah, I'd be inclined to say this is a job for the distros to have
>>> qemu-user integration, and simplify our life. THe docker.py script
>>> always confuses me.  We could choose podman vs podman --remote vs
>>> docker simply in the meson.build file, as we do for other dev env
>>> choices.
>>>
>>>> The toolchain case could be skipped if we could find hosted compilers
>>>> for microblaze. However I do see we have a patch in there.
>>>>
>>>>>
>>>>> The result of "probe" cannot be fed back in to "--engine" which
>>>>> is a bit of a mess. I think the "engine" concept should not be
>>>>> exposed on the cli, and instead have a "--runc" arg which takes
>>>>> the full arg(s), since we need probe to report the runc args
>>>>> for other reasons.
>>>>>
>>>>> With regards,
>>>>> Daniel
>>>>
>>>> -- 
>>>> Alex Bennée
>>>> Virtualisation Tech Lead @ Linaro
>>>>
>>>
>>> With regards,
>>> Daniel
>>
>> Is it me or did we incredibly derailed from original issue which was:
>> "It was fast to query which container engine is available, and now it's
>> 5-10 times slower to accommodate toolbox workflow where podman is
>> available but not really available?"
>> I agree it's sad to have several ways to set container engine, but it's
>> absolutely not related to the current issue.
> 
> It is relevant because that difference in speed is not something that
> should be noticable unless something is repeatedly probing over & over
> again which should not be done.
> 
>> Daniel, since you introduced the slow check path with podman info for
>> your personal need, I would appreciate if it's something you could fix also.
> 
> I'll looking into the missing caching.
>

Thanks!

> With regards,
> Daniel

