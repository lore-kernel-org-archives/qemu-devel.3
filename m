Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A87CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMJZ-0001nP-VG; Wed, 10 Jun 2026 13:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXMJX-0001m9-41
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:02:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXMJS-0006hK-6v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:02:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFxDS32128025
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pb4SXf2TrJRTOkvR1vHM5n9z7McSwsbPvtNMJAvm3+4=; b=aNJS0q3qA3pekNiG
 ke3xNYuM+99ZQnhZk9NtdVyxHsPJCAfovCtCNYfbQgNEpOiyAGvTzQI2HTtDnfhI
 BvTCI18SpHlODphd0cO2lPvU5la/Thxud8YndZ2LrAMzGWSbR1JMaDjsj+OfJIAv
 r7dS+Cf6y6FYdbA5Di+/w4fuEOIlcCerft6okutnxS9LMiPq0lr6/XB6CMarhO4x
 +lKMM3eNc6qXdUSGRXb5FyYNNSI91lsL21B8KjRS5SpXojYgnaKZYQPTr9O3yApD
 ihrRiIYKYBA0qauMBPfcO/g0lAJw1KSz1aeOGSCxyIm3VHlI0+MxCV+EG72nm8eN
 8iIQNg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq2sejn1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:01:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307fd7138b1so177713eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781110909; x=1781715709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pb4SXf2TrJRTOkvR1vHM5n9z7McSwsbPvtNMJAvm3+4=;
 b=gTviRqSUcpUTrBrDd+boTRwv4c6W/jgRxs2t2s0BPNfqF4aIDmZpoH0KIrllQqgUQf
 16/fkslR7NltB1Xig+Qer2jFcJqKemf3cf3TLvXxpIF1s+7aoNRsMon26aL0Rfy58ZuI
 SIoG/ZxL7fH4XFrYfppYH8VmV0gbm4gHlRb4fbjycGXgIvyYI9mNMb8JvS0rQbxTRsLT
 ukJl726P+eITl1FyrYh0MGD4LjO9B5jud5XU/c0hUkEnKIWjRyXEfD6TYSSl7GuyXz8Y
 mJoyyENN4dIvBIcS8/cytYoG6qzx1ngjWzIikKTeMzDQOP9GKt2R8E5jHNPrtYHJKvUP
 xy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110909; x=1781715709;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pb4SXf2TrJRTOkvR1vHM5n9z7McSwsbPvtNMJAvm3+4=;
 b=ZDCzk2cRNfsLLJu9RlvZAVnR2lNRrN9kNUfy7eFUcEFHLZfJrSTspAh/YuUQyr021O
 nJNy4FewTq7voZNWdLvfA3ItvkhejP9O9hO5gNXH6noBXk6RSSH/vC9WVdzP4VlldE5X
 ONoiJs+dT0A0bNo6+jRzeEycWAWaltn28D6T0JtIz4A8MWHpv85bFlF/TSoxKgAvZz65
 F7H/NATvnUIVddgFLiqrXDfAg43S+k/5qsxQC/dHCXlxDvG9jKeSTFlFHld/V0VWyGYF
 jMlM87L5HuEfn1EKvjIt1PrAWKAeMp/hVRoJokD0+GMU5PPC1wsQNbdBXDBH9SFP09KB
 NZpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9J+C+OjPs0Zb58nLOX2GfqMEf8KTNXEtf4JbHwb1jFKXWRL6fPJvQg2Li+hlYNTNhtVIAfmSvtfPtl@nongnu.org
X-Gm-Message-State: AOJu0YxEAqX9/2uMaq+fwHZzGxJXz/N9vq8KsKpAsD4zdjho8trdTWk8
 MVtpvP3O1eaP7kyEGk2XyLDa4+NL2zL7Gploi0wnIR6o/gQhcjD9BEWdXL98Xni9ufL516MBnsh
 OlMaZe+KgMS+GLijz7LyBjbdFLYjMaAHZJeCuObAKIeM9wbRBLuYXh6GZ9g==
X-Gm-Gg: Acq92OGU9SVIXZ0+z0SoFonhiaG5L3NAmtniteLqf5h0FYSJN8eHM0hoWz3eGUe7YQj
 eQWxXxdgMILst8zirE0497qbn8tWq/HAFLfUv//28zoIk1WvlYXhMt8Qfm5X5nbr6KR0mCIfs7U
 eEahx8M/bsmSaEyp+/xTJiXqkkCPjNbLjJSQyuemtnJJcuPIW1yxbq6NYuOoT+GInhDpp3QnYSU
 /v4BLtW6FLtVbFEkk4WdaF9TScnLKG3sgwlfJbyfL9du3YN/tWVbIy3odSyfvovsz7aI/BLycdG
 Tgd0fxIwxqZugJEaw67gyckdEE+tapE0zBNszcnQ9PK/VDhrMxIoZ/ePJrx250St9kyl/T8Jchb
 qJBwrX0mgYVA4KVflsvS9zv2mlxlceR8WUs5cAMlcBkSZHXALZaayKyuuokvlwGQbvsrSSCSu68
 JLZ3riNRkYM4/wlOmch7CmmsLU
X-Received: by 2002:a05:693c:2c17:b0:304:cf6c:4cfe with SMTP id
 5a478bee46e88-3077aeba998mr16251590eec.9.1781110908517; 
 Wed, 10 Jun 2026 10:01:48 -0700 (PDT)
X-Received: by 2002:a05:693c:2c17:b0:304:cf6c:4cfe with SMTP id
 5a478bee46e88-3077aeba998mr16251474eec.9.1781110907462; 
 Wed, 10 Jun 2026 10:01:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea9226sm26235176eec.19.2026.06.10.10.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:01:46 -0700 (PDT)
Message-ID: <c5945f76-ae18-4a8c-ae58-d22be7a7f6bd@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 10:01:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] tests/tcg: run tests with meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <0a0a1116-a5f3-45f2-b079-f66e6b17f672@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0a0a1116-a5f3-45f2-b079-f66e6b17f672@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pPcraisqgwNpH8WMNhnbECI0ASK5PVcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1OSBTYWx0ZWRfX4FuGarmOwAPa
 49f78EudmtDTXjDA+kRU7xfX1qMLa20bp6itQAkV4qxAr7ePh/dvEy6msiLESMpWM3+PKeZjclq
 Dno+cTZzCuF/Ttm0N3UZUNPYgOOG2TC1gWU8TMPdHsT2/ZXGZntQW9qyAXhkWP8SGYd+uzX7YBL
 vLCT3ilLXnaaQhDmV28bvjvLGDDHrKJO/tDS/tklfQQ8ttCe3dTs/0MvA3GiMohUZRPMM3e463o
 ZG4ZdmS4yZ3A9NZi9RKv1QkyO0HBvcICuHA0raefLfQIN4X+aYHcbSXRv1ZvCWuD2hG8DsjZhnR
 Evcf7FYbNzJUj7edRT8tT8jeXmvKZCSu5w49pNcqxPAmgte/IBwI9UiVheL4m3f/ppNsI1Br9/q
 9aDmnvfwXjCW08JGuTs0/S3VpWJ+et/l4cvyvJ8mj35qxIEeGZWJKBrghqOkrzXI6sEFH39+FyF
 +uNQq1ExqCiBhVDVIDw==
X-Proofpoint-ORIG-GUID: pPcraisqgwNpH8WMNhnbECI0ASK5PVcP
X-Authority-Analysis: v=2.4 cv=Md1cfZ/f c=1 sm=1 tr=0 ts=6a29987e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NIpcAeuaKk_nj2ePdRYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/2026 2:17 AM, Paolo Bonzini wrote:
> On 6/9/26 23:47, Pierrick Bouvier wrote:
> 
>> We also have for free:
>> - correct and complete dependencies for any test, including:
>>    scripts, c.inc, headers, reference files and binaries/plugins.
>> - catch test declaration issues at configure time vs test time.
>> - proper data types for variables instead of string expansion with make.
>> - we could now build tests binaries by default with 'all' target.
>> - hopefully, better readability to your taste.
> 
> Yes there is absolutely a readability improvement!  At most, one could
> say that it's not a very high bar. :)
> 
> Having to reinvent cross compilation (cc_has_feat, custom_targets for
> compilation) is not great and the only part I'm not super convinced
> about; I wonder what it would be like to make TCG tests their own
> standalone meson projects.  While the Makefiles are awful I do like
> being able to do "make -C tests/tcg/x86_64-softmmu", and in that respect
> this would be a half step backwards (and a big step forwards in many
> other respects, mind).
>

Your idea is to have one project per target, and use meson cross compile
support for this?

`make check-tcg-aarch64-softmu` is supported out of the box with this
series, without having to write a single line of Makefile. You can still
do what you like: see cover letter usage, to run a suite or a single test.

I don't see rewriting the cc_feat part in meson directly as a problem to
be honest. Not all architectures needs to check specific feat (only
aarch64, arm, i386, ppc64 and s390x).

Also, calling:
  supported = run_command[cc, check_cflags, flags].returncode() == 0
vs
  cc.get_supported_arguments(flags)
is not really much more complex IMHO, and not a huge reinvention.

Also, the custom target is hidden inside tcg/tests/meson.build and not
exposed to arch files. Even if we had multiple projects, I would stick
to not exposing test() and executable() in arch files.

> I can help with the integration of the individual test suites into
> tests/tcg/Makefile.include.
>

I would expect this file to disappear completely, and to rely on make
check-tcg-arch-* targets at top level instead. Would that work for you?

> Paolo
>
Regards,
Pierrick

