Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B208CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQPb-0005WY-8V; Fri, 08 May 2026 14:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLQPZ-0005UU-WC
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:58:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLQPX-00004s-Oz
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:58:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GWJ7s2335413
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 18:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BORBYCwHx48/hCdHuK8NfZx+UTOLo1pb9DoQmHx40Cs=; b=UcD2JPGehZ0FvSnj
 TnXTa/ECfYpLnjaMmINeB88E1ANdm7YDNXhLZ7/prtrDXTvEuhjgHmdAZH605h89
 1PdNMrJAUOr0oE9vtb/v4+ZnFBMUY8FEswpsmjx7ZWqvf4yipCDCtyj3ftxeBxL+
 Oyfc7Osb5Qg1PHpVdndUG1AIUVfXNJ9OtHVTvXgGxC3HdSsKlRnXIav7UauVBzYi
 NwEIsTUqdE/TW8W3hVOPvk/Cv17uwkprj2ibyw6BXPret8Sc+HkwrRncyPMzlrzj
 QLCqGZaLKpyht7lNfobYw1zSt0T+n42jB/UHACu8gxaVQqnYMghbjM6USCndtg2E
 cdxxEw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1keh8gas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 18:58:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso3124355eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778266732; x=1778871532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BORBYCwHx48/hCdHuK8NfZx+UTOLo1pb9DoQmHx40Cs=;
 b=aitlV8PaHGKgRd1N/xJxy7mvxb7dZ24F8JM6GuU7v3ZTGE8hU3MwfCjJpCnT1VrlMT
 kDUbf1ExIYDQxq2/tEwaGYBozOj4LVf8PgtMi4+8w5bjKkutAtB9seZ1yQZCocn5Du7U
 VIGp9OF3rAp4p2V8hP/60EeGU4UE3WOB45llVFrtCOxVN1Vaarw+MlYLKrMW5beC0Jr9
 iV9g442yR1rQrKe0UXst0v2UwGOvcxCwzVRjaHDadp00KnND4ZFCEiafL33APu6HQjJw
 OsqcRFEknnDqAlOuJM5Kz1j5zxf012+hKwWnEY5AIuEqTX8A+evT6es54M7up+Uo/TfK
 bVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266732; x=1778871532;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BORBYCwHx48/hCdHuK8NfZx+UTOLo1pb9DoQmHx40Cs=;
 b=ogT4yTpJUWREsOLqn8njVwigimUWZ50y+LQgygYRj65rP2e+cGseMfn6WSKx5DXUzl
 V/Vq0J2Cvn6EQNesqcrvaEpU0cPbYXL8GoaTKK1gVFJvpvimKJT6JohnGC4cQMh6+lol
 +UivkQTD8bYeglufaPb261WFjdIuS6wjBHmC2+ZaHdH7TSoRFoOO0dxBZoq91pynYeBE
 iRHYrXhBTkEwt8y84xjeHVEuwI0Rn7ezKtLFQgvaClhGa2mj47K4P/OIEAG6MlztS2p3
 rvsjwR3YpdPesjeHd01Wj2b5CGjjJ5HmAPyp6ko2hBvknMH382rUoppLnyNNyyijB81T
 OJzg==
X-Gm-Message-State: AOJu0Yy+lGBfhFNgJp4CCMoujpenwm5CiyZtGjg7iHspfdTMqTBj4OJs
 bnrD00LLcj8YK/DmRm6L3/TmYR2s9PL0M9jDJQN3YPnZpmN0isxLSn1IRYYp7ap+fE7R3IKomx+
 xmRRyucx6d+nBa/c8l4RyGv9cQVtxVlf+rhr83mFfRKA88mp97CnuszetkyQRSVYntA==
X-Gm-Gg: Acq92OGdIw0z/Ps0vm8YU9yy2lOAWFmvV3DXRrcdcyrAuxbolHkzUkNaRCZdjfsv0oh
 7C2UY2Hd3EWDyJQ+PsK2RaHV7Qecp9cpsNJlE3nMx4z5/F0wG6xCY9kQyUac++CrzAiKqnZuOLg
 40zmkwgGN2w9wGjrLG8CMBW/Al0pM0FrSaK0HGLhEpR30az0t5hNPbKqi6cQO6q2NvVRV2hMOsc
 OrSZ/Sdpqi4Dz/NPmbEQv7W0/PDcS+Kva7WZZYcf9DAX25aSqBTeNfF6mmETEqsrPgzYpfyZS1d
 OvbrtbDCDIDY1Ro3osAaKgJR8asSFEGBBuGNIYOFY48oE2Nstp7Qj7C4FoI2AKKJvs21BDih39e
 J+iZO+KsX2T3re7Ne1GJ/C7+YcKQ7raGBISoebr0LFX5oDQsg4u+8wbrbYdNSR0FtQ1/KF1/G+y
 gcWhNfo6VJPpSCpdAoEPksl+dU
X-Received: by 2002:a05:7300:818d:b0:2df:7882:1ce0 with SMTP id
 5a478bee46e88-2f54b364cd2mr6817482eec.29.1778266731857; 
 Fri, 08 May 2026 11:58:51 -0700 (PDT)
X-Received: by 2002:a05:7300:818d:b0:2df:7882:1ce0 with SMTP id
 5a478bee46e88-2f54b364cd2mr6817454eec.29.1778266731180; 
 Fri, 08 May 2026 11:58:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752a9sm3358025eec.16.2026.05.08.11.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:58:50 -0700 (PDT)
Message-ID: <ed1b8ae7-8aa3-4f50-8934-4900b296b45e@oss.qualcomm.com>
Date: Fri, 8 May 2026 11:58:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] single-binary: deduplicate target_info()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <af4K2fCa8SFR-C_J@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <af4K2fCa8SFR-C_J@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CJIamxrD c=1 sm=1 tr=0 ts=69fe326d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=GG8yVak5QAOh7diNAjoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: PUzEApg-6GJIP8VDRQThbMyb6Us_Uxp4
X-Proofpoint-ORIG-GUID: PUzEApg-6GJIP8VDRQThbMyb6Us_Uxp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4OSBTYWx0ZWRfX+p2dJEYBFxcG
 R3+Z30PTsKnNBWp9fs89kgq1IzT9Y+KztOhLN8xWO8wY7yUQSpnaalmFtuVNQ2rCLwAr1WgV0If
 UtALNqj/vyNC8NgBkwOgU3PnxjLbJvd4UNt6LSqRyJqvrUkajaMa2KvHKDl8GCSz4HTAj0C+kQr
 zYakcuw2yHPxHSRC7iynyA0YBZ1RDSagg1ZgPPUTKnigMNn8QZOBO746GFbTmfNwLjg7muuGZZR
 3ptwZBAVPN/QBJNZ/8R5VJJ/gkfAmbBH4+mbrka9jfTvp60Oxlg/9YgLk2OaswMTmmV3dWuECTk
 tmpshgld5d5F7arTi3meiVnDxuychapM3Ad5Hr240mgItPZtJ8GH3/WXnh2Zyx/9SpI1OhPFrAn
 IR2Tmkq1wU0HUe0GlwkIB1wIhLrTdN9aQqc5kgCI8MdZaI26MUkdXgVEfYq+9HZxSg4WR9Vzms9
 FP9W5OIrwUWU6Fbou+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080189
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

On 5/8/2026 9:10 AM, Daniel P. Berrangé wrote:
> On Tue, May 05, 2026 at 03:48:20PM -0700, Pierrick Bouvier wrote:
>> We are getting close to be able to link several targets in a single QEMU system
>> binary, and the last obstacle on the road is to embed several TargetInfo in the
>> same binary. The end result of this series is to have a single definition for
>> target_info symbol.
>>
>> This series adds TargetInfo types in QOM, and retrieve them dynamically(). At
>> the moment, we don't deal yet with multiple TargetInfo selection, but install
>> all that is needed to be able to do it easily.
>>
>> Because TargetInfo data is set through class_init, it creates an issue at
>> startup, where we may try to instantiate additional (unrelated) types just to
>> retrieve the list of "target-info-X" types. Those other types class_init may be
>> using target information, to add target specific properties for instance.
>> This issue has been fixed by adding a new object_class_get_list_by_name_prefix
>> that does not force instantiation of all QOM types, but only those matching a
>> specific pattern. This way, we first initialize and retrieve target-info types
>> before others.
>>
>> An alternative would be to leave all this out of QOM, and use startup
>> initializer to add them in a single list. However, because all the single-binary
>> work has been using QOM where possible, it would be really sad to not use it for
>> this final step. Comments are welcome!
>>
>> Finally, sticking to our promise not create a special "single-binary
>> configuration", the goal is to use the *exact* same codepath for normal binaries
>> also. It means that even for existing system binaries, the goal will be to use
>> QOM to retrieve current target, even if there is only one.
>>
>> v4
>> --
>>
>> - Revert to v2 MODULE_INIT_TARGET_INFO as Daniel didn't comment on issues about
>>   about MODULE_INIT_QOM_EARLY.
> 
> Sorry for  not responding to that, other things got in the way
> this week.
>

No worries, that's a good lesson for me about not interpreting not
having answer as a lack of interest when someone is active on other threads.

> For clarity, I withdraw my objections from v2. Having seen how
> my suggested approadch in v3 looked, I think you were correct
> all along.
>

The important is that we explored this path and its limitations.

> With regards,
> Daniel

Thanks Daniel,
Pierrick

