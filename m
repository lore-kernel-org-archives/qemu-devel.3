Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECEBC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfRv-0003gL-MX; Tue, 14 Jul 2026 11:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfRu-0003gD-Ph
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:53:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfRs-0001Fe-UQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:53:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcTSQ862709
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /4tdffdZXZ2F7UEHGDM1LPaIORPMd+8b/EtKnJArg+I=; b=lR8UTvMfLvz74zmE
 6tZlmrAoHC5hSWbrBp2gBySDW0+SS3x/FUrY7texRuSI6Y3lYXyDrNEOkvaujoXq
 6dR7MLB6CmUalZPqamfFFwUHb3DWLFFcOEd1hDe53frm+eFkeHuxv9S7xO8j/hEk
 M/njgtjmwb6aPXJC+cz0lMrAbN0VqTskvRLOqVyHRdej94WDjqsT761eesz2eqFQ
 AFQMoqUY2koOEmL0Hf3hTxAsMR+pKJWsPGSV0PPL4MbK/zzU6UC72i//4pLDjkbg
 JQ/JmZXVmTnWpCLzHns1uzrJi1F2MitnuQ5SiKOpi0hCVT/oxJW5+WaeLAggtZl1
 cX/yiw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq11q8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:53:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8409ba0easo1060039a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784044410; x=1784649210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/4tdffdZXZ2F7UEHGDM1LPaIORPMd+8b/EtKnJArg+I=;
 b=GcUozuiA8yLz8zTwl017S75fv7B1QEcdWQJjzYsgYji50QDO5OH8YORF9ATgkdI7TL
 9K0MLQEnjTyx49zUUlbu0cdN5ONJ5QyUorgoIqYv9EIxs5sMqlGrkEiJhMymvSsLHylt
 FEsCj2sg/is0g6CsQF3ZWuxyi+nlrU5sSb+jE2AuDvni2MCSfTbcQ62cCXmA9ABtSAvz
 0jikt6wIh6raWV8z9tVvSTYxt61rD/Ojl33ml1hdncqXCuL7i/iPEdbN0rKMJikJTOxZ
 3Vx+SwuQ58CY3Vlo/ZdDLuHcRGkJmXG7HA0ywF5LEl3runU9hnVw2IUpy95saDf/feQ1
 Zuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044410; x=1784649210;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4tdffdZXZ2F7UEHGDM1LPaIORPMd+8b/EtKnJArg+I=;
 b=JES85dsWPywXwNezIN7U7ywfXoWEB13AtnGlszgQlgsGh6tV++RGZHgfp9SFJCbitk
 eT4+EVueeRjqpJSPTiX5yBWa2d13PqroaylLhxI6YhqtwUvQ2kiwAUvWRQFM6zx8M6yN
 7qempQtHKWfKrDKbFMVCYAUST6rRK6gBqowDrsyuEDAUtX9qfVH5tA+8n2Xi44RSIK/x
 bBxzIeyEbN+rP7pE5lT61Co9HMgyC9jt5oCme7CeisTTTUK9MSZ8PPYPuBOfNJfZbkl6
 iISFkBf9hjYcv6sE22R3MeNUOy8VrIbSTY8K9nyNAY16z0DfgaGVnE+jAOfej86rJNPT
 C/hw==
X-Gm-Message-State: AOJu0YyyO+Yhvs0Fio5pmnkPcDNH4IaauYsOz8v+u+0JYA45vEhOuRJD
 Z7F+CptJaaHMHuPUAObc5N5mkG2iN0u1T1+2mtMTMAzr0Djk+YlipwfA7aLfESQHfqVEKpkM6/L
 Mat67I7yPcf5SEPY4ujN2BT4qSiUCoG99jGOyoLLYxyBysqsn2HxVssfMCQ==
X-Gm-Gg: AfdE7ckbdHFDDHpAuoMddoio3su2FkSxr46is1+xjDxH9+gItFvsUANX/xK9CYPDiCX
 4bEyJesSYYuz77++RdECQKbr5X56J90dqYNK0uJ5zEwcLOR8OX5hHibQswJrNYZJWF21my8I12t
 cr/eh9ZfAnPsyWDfm4d5T/gj7AZfbq+zNS9iZuUBHZAzDpFGFR8Wl78JxKwxipMKlsZlr7i7Az8
 PT2NshFnIizAJOhcj2Pw9AfSfrvA6OD3ERCY7f6tfkRotNSOiBV5ZWH+KWkxVSBphJFM3czOPy9
 AwEvC7Nd42FDfi5Te/IpZO5BD34sBLb1mhnybvmfNq53fQUJmjvNVqxp7LtrWy2/VDiGII9Lcd3
 JZbKhxKuSn3t8qPuD9Ja2ZYjL0uH/rMEiF3QjDYAh8pzDT+l5IDJnrU+T3JHyXOoz8PNC/PQ4jr
 eKdvI=
X-Received: by 2002:a05:6a20:748e:b0:3bb:2434:3d8e with SMTP id
 adf61e73a8af0-3c0f08fbce1mr21342676637.11.1784044410184; 
 Tue, 14 Jul 2026 08:53:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:748e:b0:3bb:2434:3d8e with SMTP id
 adf61e73a8af0-3c0f08fbce1mr21342643637.11.1784044409705; 
 Tue, 14 Jul 2026 08:53:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm58949794eec.8.2026.07.14.08.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 08:53:29 -0700 (PDT)
Message-ID: <8cf29764-387d-4465-b630-db1742a58eda@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/98] tests/tcg: run tests with meson
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <87cxwpj3rj.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87cxwpj3rj.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a565b7b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sUgQlV1mffvqX6SosdAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CXYIawy9I90q4DadBoeYrIN_cjh-pGkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX9MYpMBZlKs4e
 yr1gO0MntBrX9s+acT3EhCpuuysELYXOjB2DBy0FnOijJcsMIPVwd1+SEQYT+iAoQljFtKAGztE
 5Hwt/qdK6YeWCy/m1s6uPA/ODyahz7bg4aeHYq8m9D0/5FBZU3VHprCLHYeDQHV3ecaoUv133l4
 BUoOwr2jiY8c9HNPDVGfXZ+AWKQ5+c72jsupB19BiPcuBxI1ALPxqguGcUe3julbSVQ20NiuKxT
 TEoB2h5HVzR0EwpqXrtkcRcqv3NB8Aksn7b3VZ6ihRflgTRqXJZTGwoFgVY6kgbZxrfzQMO/+lI
 Ng7DRFq35jn81+D3bIjw3dUBFVCBxVNADNXKAb1zqyV2i4XcdXs9W58/mVdAoHI+NgYwBd2Sp93
 dY52QnhmSh/Hq7hIH8KQ8yZ+pfTEUjYwi2zDL+TRRzyjXmKECApFV1tHJg2wti/SbJuS3zeYOI0
 XXpb5L+2e4XJvqJNCSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX5nNYwWuq3y1w
 lK0xRe0asHvTqCDvVWt9/07agjFI4+ua+ZqlXWMtvoRURQjk0Ccv5J6GqeijIMiwDH86z+ECxkH
 x1Vv4PoHp9Kh2f2HQxHFcmaW/63dsWs=
X-Proofpoint-ORIG-GUID: CXYIawy9I90q4DadBoeYrIN_cjh-pGkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140164
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

On 7/14/2026 2:53 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This series replaces TCG tests makefiles with meson, with the
>> goal of having something more readable and maintainable in the long term.
>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>> them with meson directly.
>>
>> It covers all existing tests for all architectures, including
>> user/system/multiarch-user/multiarch-system. It implements all requirements
>> listed on original thread [1].
>>
>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>
>> We also have for free:
>> - correct and complete dependencies for any test, including:
>>   scripts, c.inc, headers, reference files and binaries/plugins.
>> - catch test declaration issues at configure time vs test time.
>> - proper data types for variables instead of string expansion with make.
>>
>> Series first introduce the meson machinery needed in tests/tcg/meson.build, step
>> by step. Then it adds support for all existing archs. Finally, we remove
>> Makefiles and configure bits, and add documentation.
>>
>> Usage:
>>
>> ```
>> make check-tcg
>> make check-tcg-aarch64-linux-user
>> make check-tcg-aarch64-softmmu
>> make tcg-tests
>>
>> ninja tcg-tests
> 
> This does work but I couldn't see tcg-tests (or individual tests) when
> running:
> 
>   ninja -C . -t query all
> 
> (which is what my Emacs's helper uses to query potential targets from
> ninja).
> 
> The plugins, unit and qtest tests all appear in the list.
>

This is because tcg tests are not built by default (so not included in
all), but they are under target tcg-tests.
Good news is that updating emacs config won't be too hard:
ninja -C build/ . -t query all tcg-tests

I enabled default build in v2, but removed it in v3 since it was really
weird to build half of the tests (with native cc available), and leave
the rest (based on containers) out of it. Now seeing your emacs
configuration, I'm even more convinced it would be very confusing to
only show part of them by default.

There is no way to make all tcg-tests appear in all target, since it
would imply we trigger container builds by default, which is a very
counterintuitive default IMHO.
Regards,
Pierrick

