Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE579CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPknd-0001a6-2f; Wed, 20 May 2026 13:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPknN-0001S9-AG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:33:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPknK-0006OX-ND
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:33:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KEFYbO963689
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 17:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nLEqt7cBukxQNjcFodu3oMs42UXSGUy93i3lU1wEe30=; b=S6nP9vL28ApZbsdy
 sDxn1GqPdFEKR492vQNWIUKHdVaj3m/kGKy8hQa65vfCk/+MhssAsuv8qdDdIOn3
 ufxLzA1d0Ui3jRNM7P/mXZ1/lV1awsh56Tqi5A0GtLhL28JuBaxbMwNVwbFRFnVu
 Iqf0lWJ63CeXjF47yAJurSGbWsTyHSdanZKw+uK/tDo2KRWTHEUGzJz7inkaAyKd
 hJjRVuInuL5CZ92HFN1OlgHx2JVs0kbLwg3r3oOBuCmQu40M40We4zuJsvi/KnoF
 mW0nOdmRb7CIPO9ztbQG4wxZn6zTERfjL1SnKfKxJ+ZBSKVTe2mZtXBlosg3nWuN
 AY/l3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh0xc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 17:33:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdd327d970so2634306eec.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779298400; x=1779903200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLEqt7cBukxQNjcFodu3oMs42UXSGUy93i3lU1wEe30=;
 b=ZMEb5eHo+6N3wXrfMIGShnulcEYc/Y9OWRT3VrNSv5yq8XG8ivlTSTsDh0JYLg+V5L
 4joUUj2jvb6Rju7Ke1+5dceoxlxcDJrDM6SLqskJFIh5s0mQaMeb4vuWCwkZN8bc5x8i
 ZapLNlacj9vtOp/0wQ33Sn+9jabDRwcJ8dh2caqAX815ezoYfTpbMtG9Pn5cHv8ttruY
 hNzjWuGIgCvg5qTSVGn5wL+x9LJ6Tfqagag88FdzRjTiqb7fW3VSG0j/NubrqM2gk5iu
 C4q7C1RmzvdvAY1fN7/ob9gs4BV7yORrThSU6QPz5DM49wh+jSBvqGLwqsbDvDo+TntW
 wl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298400; x=1779903200;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLEqt7cBukxQNjcFodu3oMs42UXSGUy93i3lU1wEe30=;
 b=DKHRLnwEzLarAP5BqPymRTux2qU+Hlbz7zpLCIn8LDqt5o/UojLUA4YneR5AWHNTwY
 3IyDYdm6jA7Wtm7oiNMHapl6VlXJX0v1PEvBzJdJMVEzu4b5/NHftFqd65LmWY3PmD0P
 YsDTNzIacwd2AC0OvInA1jk2fdzJjGQGUHva0oA+OYifKWFYB7+6n3HqjLakaSowZl2H
 pymGnPbfEftdJeZpxJS3ZfzmqdMnWHWb3Xv/+DrwDTFAI4CcR1FGmKvUCAEioDIXElyA
 hWQqqcPq4fQ8Yfypmekp9gYHQCw41NLjRZRLTQjAED3IGnof6HJgDUtF+qAp8auKppvW
 sRnA==
X-Gm-Message-State: AOJu0YzYFvxriGZhuA9i4BdWM2+lt4Cwjg8OUBRx+HRmeqd+dwJ7sohv
 bMGTZtiKOyMt4ws1K0/5Nzc6gg/7QygfGCZy8yc8+I+APsblN+5/cI3+osR9bE9dOxcY1fsHOi4
 B2581u2u7kq6o7HXU8D0ZBl5WIeLJyOhySjATQ1/6W87lLCOh4q86R7DLCA==
X-Gm-Gg: Acq92OH4dndjml4xPPGuRX0xs81rX3G9qOX5+SYhtZFG8cboONRkxBLjqco4VWDPa2L
 P1ZVbYKLxeoJqpTePCebBMrdYatS0nebfAcHKh8jBGJcyo2ZWDvRYdjR/at1TN/0OwDVelmsIyS
 65lnPU5cARyQlVIz29V0o5L7bxVkK9g0FfS/z0tiHqn9rzEjvc6NWr1YZi1ev/RnxcyeFj/ZEyc
 NiUWWc2zGdTz+Juaa2UMHCYEOlYst6jEq/MKEa1vH7hVxfk8z53PngtIt4f7y1wygVgolwhJsSr
 YCrujnhfP+JJEbiqJG4tTYW0aJJiL6s37p/nKXQ5mdRDQ1XoQYI4F1PQwZJQfv/W0+HdM+PhbsU
 qVklo8J8Yi6qcq8+fLUpL3LKQ7qCpuOfgABMD3WvIvKk7PSnS3EzEXCg=
X-Received: by 2002:a05:7300:6ca6:b0:2df:7882:1cf3 with SMTP id
 5a478bee46e88-3042b30768dmr294268eec.2.1779298399827; 
 Wed, 20 May 2026 10:33:19 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca6:b0:2df:7882:1cf3 with SMTP id
 5a478bee46e88-3042b30768dmr294244eec.2.1779298399202; 
 Wed, 20 May 2026 10:33:19 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm18589481eec.21.2026.05.20.10.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:33:18 -0700 (PDT)
Message-ID: <e7f1fd11-774d-4610-8cca-a434f508e472@oss.qualcomm.com>
Date: Wed, 20 May 2026 12:33:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: GitLab issues for security disclosures
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
 <ag3OopKwGVUjSrrV@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ag3OopKwGVUjSrrV@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0df060 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=56Y9rEFZEhgGDzydt2dtyA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EfI3L7-Hv9Vo3Lfrq5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3MSBTYWx0ZWRfX7DmUNQ47OHaS
 KYljWHRT3HznNDbjkY6+k+HWNJzt/4D2fgILfJh1GGKf7aEo0Fig+NAJr0x+VU1oRwW2RbSX1dm
 f3NTkkwNJj0X9UgYJkGlE+SbFImZRgR1CT5nJLvcYqG7vdEjkFre0N43UF/pMK0ItdVXmB6fr+p
 2cfOMIV5SSBfl5Z847YlcALSRMcfUFasSeYwoKYaHCwdU7GphDaHcm321o61Cfnqb+b1oWb2AW1
 IRFNXJ80qzBfBoExjRzzOiNgKDFrQ+Hl3dKPVBeKaIvcE/FspZZaYFZjrO2aW17qzgfki+Sp+74
 5wDgCFYy14JYQIDzbTG+WBAHQGsAkuPLDVUILr9dIntTcmUJ04x1GnoS5gaq2ixXBoIy6ZWfNje
 XkjIlbs5UxpDNb5BcyhHcQK73C/vd0UQBj8WwX8B2Ls2mkj19LI2/SUj5EnfACmQwh+y8kdSEwl
 p1mvZBQHUkogJkQRaFA==
X-Proofpoint-GUID: H4eVvBC6-t23ItGSxabEYSPMZyX0PkmZ
X-Proofpoint-ORIG-GUID: H4eVvBC6-t23ItGSxabEYSPMZyX0PkmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200171
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

On 5/20/2026 10:09 AM, Daniel P. Berrangé wrote:
> On Wed, May 20, 2026 at 10:01:14AM -0500, Pierrick Bouvier wrote:
>> Hi Daniel,
>>
>> On 5/19/2026 9:26 AM, Daniel P. Berrangé wrote:
>>> The qemu-security mailing list was created several years back now and
>>> traditionally saw 1-2 disclosures a month at worst. This was manageable.
>>>
>>> Since approx March 1st, the new normal is to see as many as 20 disclosures
>>> in one single day, more than 200 in total now. This is unsustainable.
>>> I was thinking we needed more people on qemu-security to triage, but IMHO
>>> this won't really fix the problem.
>>>
>>
>> Considering the increase in number of issues, would that be possible to
>> make stricter rules about what is expected?
>>
>> For instance, asking for a working exploit and optionally a VM image +
>> instructions to reproduce it. I am not expert on the topic, but what I
>> see is that if we have this, all duplicates would be eliminated at once.
> 
> With the new crop of AI assisted disclosures there is absolutely no
> lack of data provided.
> 
> Most come with reproducible exploits, detailed descriptions and analysis,
> and more - everything you could conceivably need to triage the disclosure.
> Reading and interpreting this takes significant mental effort and there's
> too much data to quickly/easily eliminate dupes.
>

Maybe we need to "standardize" this part then.
Or do something like asking a (GitLab) CI pipeline to be written to
expose the issue. If we can just run this with a specific qemu
remote/branch, it becomes trivial to rerun it when fixes are pushed.

It definitely does not solve the original scaling issue, but maybe can
help to absorb it, and spend time where it's useful: writing and
upstreaming a fix, and check it "broke" the exploit.

>>> This needs an issue tracker to cope with & email is not an issue tracker.
>>> We faked an issue tracker with a shared spreadsheet to prevent us drowning
>>> these past few months, but this is still not sustainable & probably won't
>>> ever be.
>>>
>>
>> Overall, you're right.
>> However, changing the tool won't solve the number of issues sent, and
>> for that, something additional is needed.
> 
> I don't expect there to be any change in submission rate. The proposal
> is based on the expectation that the submission rate will continue at
> a high level for a long time. Primarily the goal is to reduce the
> tracking and triage work overhead and to eliminate/reduce single person
> bottlenecks in the process
> 
>> I wonder also what is the percentage of duplicates there is from what
>> you observed in the last 2 months. Any rough idea of the number?
> 
> Definitely at least 10%, probably closer to 15%.
>

Ok, interesting number, thanks. I was expecting much more, but I'm
biased having heard Linus this morning talk about this for Linux kernel.

> 
> With regards,
> Daniel

Regards,
Pierrick

