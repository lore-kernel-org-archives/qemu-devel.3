Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C24606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IhDWpvOP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h9/g7kTg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5kK-0004Cs-Ht; Mon, 16 Nov 2026 18:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT5kI-00045H-45
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:04:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT5kG-0003q6-EC
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:04:17 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCGUK2710529
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +LYiEriCXViip2zjDX16EmH8eshRK2C/3AH4eAk5pC4=; b=IhDWpvOPAJbkBYLc
 m89ngNGOyeQB5CtRQoXv9hua9h964Gqlfycb9Glbsa4U8akb8n4Td0W3rY2OK+Fw
 38JJbwdUbevROxpHJC+YRZ9bsM6WzCzdr80t4Fb+va/JpShZN5g4VjTkNRELjWlA
 AUNgFVLFa39MwijQVeaUj97o3exsVxVZsYdC8zvqgDAxTtUehFTZvuEBK6UDPs96
 o0AxI5i8O7M1H7KT3bGP+45RztFJHFQkzWqGtmTukeAodZBGUUo6V73vqsx8lIXd
 lIGxLnxephBDXzR8MgMBhU2DC25dAKnoZmG4+XwL8eP5GO+M796E2AvDu6LK3112
 P0YmjQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htgabn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:04:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b3ae17c536so3370854c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794870254; x=1795475054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+LYiEriCXViip2zjDX16EmH8eshRK2C/3AH4eAk5pC4=;
 b=h9/g7kTgZMQ/8wJkM0xWVNwjvyox3sNLAL2V5f7sqePY4mzTlCqgMxtJzfCot/JoAh
 +k2/NMLiVqGXgzVhqjvkJK3MfmP0DHaXK2VuxMEbKVITlfvXXWrpHjEXjsccTDBuPIsy
 FLwj8ihmOAM3JM2Mfdr16T0s//bv0ITvkUBNeiYy2eNSBQ2tMDVe5T0yur4FVPNJs2XP
 kEt1aL7GjrOqupX+51cvao7r2z6myIdac7zUJlcweyW9BN3s5A/ct+8pJVpBYRKo1qrY
 XNdIikaLRkoEro9PirO59g+yVs+45nFrZb71KZrwQ6xGh4j3Qe9LGhYDvn3Xh2UMifrp
 rJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794870254; x=1795475054;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+LYiEriCXViip2zjDX16EmH8eshRK2C/3AH4eAk5pC4=;
 b=Xs1hL3Tb/7d1UI0A0ZbPHqjdszZ1dEulG7RzVz8gfwm5DZ6d4cmbiiO8fvKt9NuTvP
 AlRZVKhqgZZl8OkrNUddCy3H9ELE9HjgDphBdANRsDnIsZ98WFpOUHm9w60XCYco/cHw
 3s/kcgEPgnmCD3QdtI+RucEJElCW15ZI4Uf2ye31uX2pE7/3yDy8mlLH4WbwjKUJKV8s
 wnMxGxn53EvmywUeEROtqKTDfoi7mq2zGVSNtIEIwuH39pLYdUXx+WdC6t+0KVG+igBy
 Qi3y1GJMBHNHyrOIr1IqrUsQXQnYkmvjwA+QjtM0Z/Z3h5TLNa8rsIFYWDPUOzoAM2cH
 Imrw==
X-Gm-Message-State: APuU4Z84XnC36wZOsLyS7ICRUPk7+BC/GRigFZxqDQEet34A5Ein8lLc
 HwTukdNFAoHHDnV2KY+6JrASc9rhP5gPLfztMoKvkQcSbD9iTrkHkZUFmfzxpr4uMYc+XWbP1+2
 sfuMce+a5qw1etL7COoed7w+gH6seMr9eRhGmLkUiSXYblGROWWWW0m3hSw==
X-Gm-Gg: AYBFou386+0LcHGQ4ZEoJjcpQB/zPbtS5aO6cc15E+l7awUx1vR/IAMS5T62V3g4fiu
 cfBYV2vqWYk11wLes/eajq7/NbnYfkyU3ZVJ7EhCD7IDI0Ho7xFshRza0OXwvgDWW957sKytBMe
 GVPo6kV1MiQg+zZ5ghcMQv3RM2dTFK9HgXbuxKJEk2ABaaGIawbOZdAmwdO8uW+qnEUiTKg5AWX
 vyvR/29bnV/qURQ8wKYSvF2MFOAU338EGcqhAein+U13FwxkKDAn38mnFE4XxH+S8E4ZZcgiVlI
 LWqox7yf9dpz/VvaCHRayfAPvEqW8YyuVAxX9BgrkNjlbdhIR9V16Ebq65whA4oXa+hRUHTEXtD
 N+/qGkxmZVsog8iavxBCMiaw74l3q3BLUiciSpVCBohR2TNFVovgnt1b0bHVdk4vHG7qkDXy5a/
 wkG3IapmshKm8c/kc07A3D5Mf9hEhIR6+87N9jMF/D1rc=
X-Received: by 2002:a05:701b:4642:b0:1b2:42e3:e5f0 with SMTP id
 a92af1059eb24-1b5030eb063mr9936676c88.12.1794870253691; 
 Mon, 16 Nov 2026 15:04:13 -0800 (PST)
X-Received: by 2002:a05:701b:4642:b0:1b2:42e3:e5f0 with SMTP id
 a92af1059eb24-1b5030eb063mr9936652c88.12.1794870253065; 
 Mon, 16 Nov 2026 15:04:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b524049e0asm15896701c88.4.2026.11.16.15.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 15:04:12 -0800 (PST)
Message-ID: <3547315f-ca86-488e-a114-7dd892998f8b@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 15:04:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
 <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
 <ccfcea11-ada8-4753-a71f-f59ed1bcb067@oss.qualcomm.com>
 <CAFEAcA9FE_dTUo5s2g7DMw9-ZhbjBUOfF0RJxdT7gMwm-rYuGQ@mail.gmail.com>
 <558f35d3-5a10-4652-8af4-4a88f382ca3d@oss.qualcomm.com>
 <CAFEAcA_gBzv7URWJNjXwjUbKOJuRQ=bd1NS9enpU_AW_tCZzvg@mail.gmail.com>
 <b0633aca-736d-479e-b6fd-743f5ef23035@oss.qualcomm.com>
 <f8113426-968f-4e96-bf1f-f80f2de6642a@linaro.org>
 <b9ac4b40-6457-4de4-b362-fef53be58cd5@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b9ac4b40-6457-4de4-b362-fef53be58cd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfX7yV8a5SMb//b
 BqfpkL5PB+hZWDuoVu28LN1MUWo8mwecl+Adyo7pQVy/JV6TlkY4tnB/uMJmHsDJK/N9GqKTpE+
 XqO03F7Zsoa+w4RSAps/j2cZTHYvgTc=
X-Proofpoint-ORIG-GUID: etRfTFpyxmR5Fzv5IRQWvxhEGyr96wWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfXx2hFcrQxo6xG
 Svunlk80u8mZY8e/vgXoMsw/UCpNrTT63gVQ1LmynXsv5XRdqAHJTUXdMQSqQgYM+7FSXHhsKUC
 3TdsMTVF3H3/ZH3fSeW7pYJtxaVZLQUuayG1Fjmj1y46Vx2bRsqMCl6HA1UbGdbOu0/SdG4exLx
 sYOb9KQ7hDn9PhbIcz4S0VgLSz3sooAJxjXvIBXKgbGEhI+yQHpJaxeITJB6wtHW3ZoMqHPW9am
 ZfjUfASZ8RPFunDxfw6hdw9VxGWyLRAP0c8LTiw4YR4Vsl5wflwh8hcj6dBU6aIxPUmIjRL/WqU
 e4KNwXjvShL3UVkuX8i34+koARVnK5u1geAarBSPURO/ceb2DJ17yfOhVne556XUytytTJlDaFn
 UEgjy8kO0ukhGCVYDTs4+2CQSKYfshCTcOnC+r4YGGXURbpDfJSKwXDo1AwN1QTrXeO1pmtucAF
 wfT9yEdg3otJEUeLpvw==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb8bee cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=sEcWKaIgVgPjtOG_hF4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: etRfTFpyxmR5Fzv5IRQWvxhEGyr96wWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/2026 3:00 PM, Philippe Mathieu-Daudé wrote:
> On 16/11/26 23:28, Richard Henderson wrote:
>> On 11/16/26 09:05, Philippe Mathieu-Daudé wrote:
>>> Tangent to this, it makes sense to deprecate quickly enough on
>>> QEMU side when a host-related project we use deprecates / removes
>>> it; when this is guest related I don't see the urge, in particular
>>> when the maintenance is almost zero cost. For the particular
>>> aarch64_be I agree what we lacks is coverage testing; but for
>>> other features I'd prefer we keep them as long as there is interest
>>> within QEMU users, independent of external projects change like
>>> the Linux kernel.
>>
>> There have been a couple of attempts at aarch64_be, but *never* any
>> upstream traction.  qemu-linux-user is about emulating Linux -- you
>> can't divorce these two.
>>
>> In my opinion, those that want to work on aarch64_be can work in
>> system mode, where the endian switching bits work as required by the
>> architecture.
> 
> OK I'm happy dropping Aarch64_be. Patches 7-10 are still common to all
> targets and worth review comments :)

Beyond aarch64, what about qemu-arm and qemu-armeb?
If we all agree to try to unify that, I would be happy to help review
the series.

Regards,
Pierrick

