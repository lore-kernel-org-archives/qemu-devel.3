Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B1BCA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGTeP-0006lc-DU; Mon, 12 Oct 2026 23:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGTeK-0006kO-AV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:58:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGTeH-0007hA-Q7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:58:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21GcG3752760
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xQW+f6+B1/sL6c37AZDajwDvYfbuQxBicfCoQESiv/k=; b=FPW1/oduKH4IooR0
 MW3uprODv/G83VsJJQnF0K5vPunm9Xf5YTZ+MEor+m2kJJ4nQGm6cquFVSW/u72k
 AWmx5QaIYzochFj7sKSDiOu4zkTj4H8ZGBthhcI+PJY1ydJwp4isJNsvhliU2rQ2
 BwNMYOAHpO2k/lDC6hlwOsFhDfgP4hWqY1FWLjRYWXfDzfMveXLXxw1JgwiLFHTU
 Ilh5/Vn6/wKKPx0sXZrSVlyTeeTjkUx2WKV1+51eRhccicnh1C3EZchhLqMRqE7g
 8sVSxxbnCNQDuR0P6NBeh6Gpv306U/y1hBfpqT1uywDk4cYdTsgg0MNrsfW4DDey
 IxFx8A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w22j1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:57:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a7d2f25f65so3213726a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791863875; x=1792468675; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xQW+f6+B1/sL6c37AZDajwDvYfbuQxBicfCoQESiv/k=;
 b=K38VVkY1NPeo66TmLBlvWXfVVfMxT3ubxcQmKxxzdKsoK4hHXke4gmFrljrYa4lDJP
 ZukyTpI8sjEyiCg6fywUWdVj74H1/xGPG592ZYWWKQzpeSbfe489+tsSraKWd6BGcFMv
 KoFdNIrB1BBmDAajastU7pBSYTuWu0n/PosCP60Yo5UOTH4uIDywLEok9jWjRYgOQMGI
 CiDi0z9q6fKeD6ihAX35ePx9Z1zXcvF7iUcbwpg4m0d+b7x56BiZ6GOyBYNVgx+TbVoR
 MSFrg5CTOU9AMngJ17EBlp0MkQcaUtzMoYIe6AsWl6XUDi/tkJYfsnbwCIx6eiN9AF5S
 wnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791863875; x=1792468675;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xQW+f6+B1/sL6c37AZDajwDvYfbuQxBicfCoQESiv/k=;
 b=Vb8htFs80QJpjkBDO1i3vgve7MInlozj2i4uaIJ+SFqRjbGLRurNvJ2JKAcocT8sSM
 17+6cSin18sgXK/XgmCpBAXY/GeNZu/6GoEXX1MWq0BcdYBv2Cl+qIp7BF8CHLXVoW84
 CbAUg2TvDFOEml/fCyo+0QaoqkfpEcUsEWRqoghPDzcKiPChlsVpWfgEQmhPWuFkj8xv
 xyXsSx5q/XS3dSRjyu1Os+4XodPECb30jO/b6tQ+IM6zfvN8l1ETcet16YvjEy+z6iVN
 VRqn7G6Jp3DTfWpg969HXgvysqL4bWR8iQw86NusBngogrt/7iuvFHsUurSS+q1T4Dm7
 mwZg==
X-Gm-Message-State: AFq9FYLEpgm0YbNS3hyO5N4pCX+mzc/op4Fb9rDYZ4ZcoAU7dzd6laDX
 UWirahA5TrG3MJgSDkZm337MYnZ0pU2Pnv/3QC4UOz3akJ0ButgY8l9gA/hzoS7Itm3p+kgppoT
 Fl/M9PGjU2+LdAe8su3AO2VPRRktXgfHD0+JdMA3Mc2a5esi6DVetrJOctw==
X-Gm-Gg: AYBFou2bUmNMGpFnN1lj98KIOYfRa7oKcY0kRhvzbPLgPEa/KBG50VwCPPHWXqmZ8bI
 VPta0Vg7Y3rzfGlo/WeFW/C2ylJoy8LhjLOeFKmk7DZRhWK2wu8YHlTz+pBdkWEQD0BWumgBBuo
 pfU+sosixo29YM6AYkGXKE/hYtBWxw8NDBLUeuNBC1ROVtC3RUiEJYPP3TbqI0IXQlQlk2GRbUp
 ZoTHPmVpKve+7VPIMw+F7QwJaEY+NJsD/CPG4yIG5uB8f9ItN5Ev8VtRnHNifC8K3SR0QPMjrH0
 qRY1V64vK81KZ77N6nfoZ5z8vlN4toA6cv2FhAMAqJKa1HLSS65Afm0CtDg4i/XvExBEfA73ukr
 NOYMV40eZM3Xr1hnuFP3koFn3rB/nFrcnM5uY62VszNLstZDJ17JPHshB
X-Received: by 2002:a17:90b:2d82:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3ab3acdc391mr5559018a91.38.1791863874688; 
 Mon, 12 Oct 2026 20:57:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3ab3acdc391mr5558993a91.38.1791863874028; 
 Mon, 12 Oct 2026 20:57:54 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38dd5864sm18800480a91.8.2026.10.12.20.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 20:57:53 -0700 (PDT)
Message-ID: <f011e6c6-4588-437b-ab22-ab83ed7b8850@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 20:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target-info: replace QOM registration with a
 constructor list
Content-Language: en-US
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
 <CAE2XoE-XeHnywvAGOCgxO30a_qCMgxbnBF5kjtStGa9=5D=Rkg@mail.gmail.com>
 <72ed88c4-5f31-46c3-ab48-fdaa7c2743b7@oss.qualcomm.com>
 <CAE2XoE8mHnaB8rgcE-ZsetpyK6dWSmU9dzRbdVJPb_w4F+1OWA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <CAE2XoE8mHnaB8rgcE-ZsetpyK6dWSmU9dzRbdVJPb_w4F+1OWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NK-G49WXWILr_0rPgEdp7sXyUj8mUgk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAxNSBTYWx0ZWRfX6iSdb/ANFYA4
 wIQI9Wjejy0zmxljyIG1cTvaWngFxG8DugihbukVAotc0BO+e1HASFYohWJtaIrMOfBJ7kr3hib
 VpS3WXSCdAwqVKwCGNyosqBvpxnw3wykU/tyL/ChwrkXbp4VbCazUwP03vJzaMENYtj+8dZ0rob
 LjNcPHnphj9WF8QB3SKFLXZkIoHTDCBpWoLoygoz2rGrOeaI4QZ3I2UMZHrMR6Cau3s+4Mggubz
 nyiKiaOGqzCQR67QXBkGwG9bhNGd8uQc6okZZcgpe7aN7f8cIXY9xf6ljvtHcqxMbYD8V/AOzwv
 +e69heQZn0h44HJ44tN87/t2Eai+uwXeGMylUGTJxOJzWOadB6PQIM1JRB1+XOEHA7Fw6rJT7aK
 tVfRegyqAR20lhU0Qepldp/qzrgFE2+dCZHpta5CEtDsHw+HaG6iYZ8RDguW2R3DxCXbQ7rLuoh
 O1vGaTUSYD6F9gV7xqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAxNSBTYWx0ZWRfXx0NwWa1vTb5A
 tb7RNJAkQNihjuzxiYl4Yjy2z4eQ0kyuucHsEISPMhRm8g7iuRz4OSfi2sF0oJeYnc67QK8Eic/
 HRZcEazRQ3j9Cgdj4oDf5jV3y0S93uE=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acdac44 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=B5X00TPWD9_FxeURYkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: NK-G49WXWILr_0rPgEdp7sXyUj8mUgk2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130015
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

On 10/12/26 2:27 PM, Yonggang Luo wrote:
> On Thu, Oct 8, 2026 at 7:28 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/7/2026 4:02 PM, Yonggang Luo wrote:
>>> On Thu, Oct 8, 2026 at 6:31 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/7/2026 1:50 PM, Yonggang Luo wrote:
>>>>> On Thu, Oct 8, 2026 at 4:29 AM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
>>>>>>> Register target definitions through constructors instead of
>>>>>>> MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
>>>>>>> available on entry to main(), without explicit initialization or a
>>>>>>> call to module_call_init(MODULE_INIT_QOM).
>>>>>>>
>>>>>>> Keep the target list sorted by target_arch and default to its first
>>>>>>> entry. Provide an unknown TargetInfo fallback for target-independent
>>>>>>> tools such as qemu-img and unit tests that link no target-info-def.c
>>>>>>> objects.
>>>>>>>
>>>>>>> Remove the obsolete QOM target-info registration infrastructure and
>>>>>>> update the multi-target test to inspect target information before
>>>>>>> initializing QOM.
>>>>>>>
>>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>>>> ---
>>>>>>>   include/qemu/module.h           |  1 -
>>>>>>>   include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
>>>>>>>   include/qemu/target-info-init.h | 53 ----------------------------
>>>>>>>   include/qemu/target-info-qom.h  | 31 -----------------
>>>>>>>   include/qemu/target-info.h      |  9 +++++
>>>>>>>   meson.build                     |  6 ++--
>>>>>>>   system/vl.c                     |  4 ---
>>>>>>>   target-info-def.c               |  1 -
>>>>>>>   target-info-qom.c               | 60 --------------------------------
>>>>>>>   target-info.c                   | 61 ++++++++++++++++++++++++++++++++-
>>>>>>>   tests/qtest/fuzz/fuzz.c         |  3 --
>>>>>>>   tests/unit/test-multi-target.c  | 12 +++----
>>>>>>>   12 files changed, 129 insertions(+), 168 deletions(-)
>>>>>>>   delete mode 100644 include/qemu/target-info-init.h
>>>>>>>   delete mode 100644 include/qemu/target-info-qom.h
>>>>>>>   delete mode 100644 target-info-qom.c
>>>>>>>
>>>>>>
>>>>>> This approach (custom list based) was considered before implementing
>>>>>> things with QOM Types. The rationale I followed was that if everything
>>>>>> is in QOM, we might better follow that for consistency sake.
>>>>>> Yes, the compromise if that we need an extra init step, but it was not a
>>>>>> problem to add it.
>>>>> I have issue to add the init step for unit-tests, and hard to write the -target
>>>>> parse procedure and get it right. Not means this won't work. but for
>>>>> me, too much
>>>>> coupled.
>>>>>
>>>>
>>>> We already have such a test upstream:
>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/unit/test-multi-target.c#L35
>>>>
>>>> The init sequence is quite straightforward:
>>>>
>>>> ```
>>>> /* initialize target types, and only them */
>>>> module_call_init(MODULE_INIT_TARGET_INFO);
>>>>
>>>> /* we can get the list if we want, for -target or any other purpose */
>>>> g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
>>>>
>>>> /* set the global target info from any element in this list */
>>>> TargetInfo* ti = ...;
>>>> target_info_qom_set_target_info(ti);
>>>>
>>>> /* register rest of QOM types */
>>>> module_call_init(MODULE_INIT_QOM);
>>>> ```
>>>>
>>>> It works fine to implement -target (if we would like to do it), since I
>>>> implemented it myself. That was also my initial motivation by the way.
>>>>
>>>> Also, I appreciate that target-info is NULL by default, it crashes
>>>> loudly when it has not been set, and make it easy to find who depends on it.
>>>>
>>>>> If we treat target_info as a QOM, but QOM needs target_info to set
>>>>> up(is_avaible). That makes
>>>>> the init sequence too much of a burden.
>>>>>
>>>>
>>>> See sequence above, the solution is to initialize TARGET_INFO first,
>>>> before the rest of QOM. You end up with the same result than with a
>>>> statically initialized list.
>>>>
>>>>>
>>>>> is_available is depends on target_arch
>>>>> And before this patch, target_arch depends on QOM, pulls user/softmmu because
>>>>> target_info_init. By moving target-info to be a custom list based, we
>>>>> can decouple
>>>>> target-info from qom/softmmu/user. and target-info will always
>>>>> available once "main(argv, argc)" is entered. We also have the
>>>>> advantage of doing all sorts
>>>>> of tests against it.
>>>>>
>>>>
>>>> Which kind of tests are you trying to add?
>>>>
>>>> For now, the exact list of places where we need to do this initialize
>>>> target dance are:
>>>> - system/vl.c:    module_call_init(MODULE_INIT_TARGET_INFO);
>>>> - tests/qtest/fuzz/fuzz.c:    module_call_init(MODULE_INIT_TARGET_INFO);
>>>> - tests/unit/test-multi-target.c:
>>>
>>> # Multi targets test
>>> if multi_target_objects != []
>>>    test('test-multi-target',
>>>         executable('test-multi-target',
>>>                    sources: [multi_target_crates, files('test-multi-target.c')],
>>>                    dependencies: multi_target_deps,
>>>                    objects: multi_target_objects,
>>>                    link_depends: [block_syms, qemu_syms],
>>>                    link_args: multi_target_link_args),
>>>         suite: ['unit'])
>>> endif
>>>
>>> I see this test, I am trying to add tests that do not pull so many
>>> multi_target_objects, as it would be huge.
>>
>> Agree, we should not add more binary.
>> If you need truly multi targets test, this existing binary is a good
>> place to start: just add a second test in it.
>>
>>> Just pull qom only.  And I am trying to call target_info() in
>>> object.c, as inspect machines with
>>> qemu-system is rejected, so maybe that's not an issue anymore
>>>
>>
>> Seems like a good candidate for the multi-target.c test.
>>
>>>
>>> I means Subject: [PATCH v3 00/10] machine: uniquify virt QOM names
>>> https://lore.kernel.org/qemu-devel/20260926081551.29-1-luoyonggang@gmail.com/#r
>>>
>>> So the current design always rejects types that do not belong to the
>>> current target. Listing them
>>> all is not an option at all. With this restriction, then these are
>>> indeed not needed.
>>> So I'll wait for your work first, otherwise it's always conflicting.
>>>
>>>
>>>> module_call_init(MODULE_INIT_TARGET_INFO);
>>>>
>>>> If we want more tests, I'm totally ok to move this init code to
>>>> target-info.c, and replace call sites if needed.
>>>>
>>>>>
>>>>> Tools such as qemu-img and unit tests may link target-info.c without any
>>>>> target-info-def.c objects. Their target list remains empty, so use this
>>>>> fallback.
>>>>>
>>>>
>>>> Why should this tool get access to target list? qemu-img deals with disk
>>>> images, and is unrelated to targets.
>>>>
>>>>>
>>>>> static TypeImpl *type_register_internal(const TypeInfo *info)
>>>>> {
>>>>>      TypeImpl *ti;
>>>>>
>>>>>      if (!type_name_is_valid(info->name)) {
>>>>>          fprintf(stderr, "Registering '%s' with illegal type name\n",
>>>>> info->name);
>>>>>          abort();
>>>>>      }
>>>>>
>>>>>      if (info->is_available && !info->is_available()) {
>>>>>          return NULL;
>>>>>      }
>>>>>
>>>>>      ti = type_new(info);
>>>>>
>>>>>      type_table_add(ti);
>>>>>      return ti;
>>>>> }
>>>>>
>>>>>>
>>>>>> Is there another good value this list approach brings compared to what
>>>>>> exists?
>>>>>>
>>>>>> Regards,
>>>>>> Pierrick
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 
> Hi, the cycle dependencies issue happened again, deal with it's a bit
> nasty, there is workaround, but I think
> the constructor list is the best, here is the rationale:
> 
> 
> # Target discovery during QOM registration
> 
> ## Problem
> 
> Machine registration needs the list of targets compiled into the binary.
> Currently, it obtains that list through:
> 
> ```c
> object_class_get_list(TYPE_TARGET_INFO, false);
> ```
> 
> Despite the filter, QOM initializes every registered type before checking
> whether it implements the requested type.
> 
> During `MODULE_INIT_QOM`, registration is only partially complete. A device
> may already be registered while its parent's registration callback has not
> run, causing failures such as:
> 
> ```text
> Type 'sys-bus-device' is missing its parent 'device'
> ```
> 
> The parent is linked into the binary. The problem is premature
> initialization, not a missing library.
> 
> ## Option 1: cache target-info QOM classes
> 
> Enumerate target-info classes once, before device registration starts.
> Machine registration then reads the cache instead of enumerating QOM.
> 
> ### Demo
> 
> Declare shared helpers:
> 
> ```c
> void target_info_qom_init(void);
> const GSList *target_info_qom_get_targets(void);
> ```
> 
> Implement the cache:
> 
> ```c
> static GSList *target_info_classes;
> static bool target_info_initialized;
> 
> void target_info_qom_init(void)
> {
>      if (target_info_initialized) {
>          return;
>      }
> 
>      module_call_init(MODULE_INIT_TARGET_INFO);
>      target_info_classes = object_class_get_list(TYPE_TARGET_INFO, false);
>      target_info_initialized = true;
> }
> 
> const GSList *target_info_qom_get_targets(void)
> {
>      assert(target_info_initialized);
>      return target_info_classes;
> }
> ```
> 
> Initialize it before other QOM registration:
> 
> ```c
> target_info_qom_init();
> module_call_init(MODULE_INIT_QOM);
> ```
> 
> Machine registration uses the borrowed cache:
> 
> ```c
> for (const GSList *l = target_info_qom_get_targets(); l; l = l->next) {
>      const TargetInfo *ti = TARGET_INFO_CLASS(l->data)->target_info;
> 
>      machine_register_virt_type_for_target(info, name_suffix, arch_mask,
>                                           latest, ti);
> }
> ```
> 
> `target_info_qom_set_target()` should also use the cached list instead of
> enumerating QOM again.
> 
> ### Advantages
> 
> - Preserves the existing QOM-based representation.
> - Avoids enumeration during incomplete device registration.
> - Requires relatively small changes.
> 
> ### Disadvantages
> 
> - Every relevant executable and test must initialize the cache before
>    starting QOM registration.
> - `object_class_get_list()` allocates list nodes.
> - Callers borrow the list, so it cannot be freed while they are using it.
> - Cleanup is possible after all consumers finish, but requires an explicit
>    lifecycle policy. Keeping the cache until process exit is a lifetime
>    allocation, not inherently an unreachable memory leak.
> - Target-info types registered after cache creation are not included.
> - Target discovery remains coupled to QOM class initialization.
> 
> ## Option 2: constructor-populated TargetInfo registry
> 
> Each target registers its immutable `TargetInfo` pointer directly.
> Machine registration later iterates the registry without querying QOM.
> 
> Use a statically allocated node per target so registration requires no
> heap allocation.
> 
> ### Demo
> 
> Define a registration node and accessors:
> 
> ```c
> typedef struct TargetInfoRegistration {
>      const TargetInfo *info;
>      struct TargetInfoRegistration *next;
> } TargetInfoRegistration;
> 
> void target_info_register(TargetInfoRegistration *entry);
> const TargetInfoRegistration *target_info_get_targets(void);
> ```
> 
> Implement the registry in shared code:
> 
> ```c
> static TargetInfoRegistration *target_info_targets;
> 
> void target_info_register(TargetInfoRegistration *entry)
> {
>      entry->next = target_info_targets;
>      target_info_targets = entry;
> }
> 
> const TargetInfoRegistration *target_info_get_targets(void)
> {
>      return target_info_targets;
> }
> ```
> 
> Each target's translation unit provides its own static node and
> constructor. For example:
> 
> ```c
> static TargetInfoRegistration target_info_registration = {
>      .info = &target_info_stub,
> };
> 
> static void __attribute__((constructor)) register_target_info(void)
> {
>      target_info_register(&target_info_registration);
> }
> ```
> 
> The constructor must run exactly once per node. The existing target-info
> initialization macro can generate this registration code alongside the
> QOM registration code; user-mode target-info behavior should remain
> unchanged.
> 
> Machine registration consumes the completed registry:
> 
> ```c
> for (const TargetInfoRegistration *entry = target_info_get_targets();
>       entry;
>       entry = entry->next) {
>      machine_register_virt_type_for_target(info, name_suffix, arch_mask,
>                                           latest, entry->info);
> }
> ```
> 
> The sequence is:
> 
> ```text
> Target constructors register static metadata pointers
>      ↓
> Startup constructors finish
>      ↓
> Machine registration iterates the completed registry
> ```
> 
> QOM target-info classes can remain available for introspection.
> 
> ### Advantages
> 
> - Makes target discovery independent of QOM initialization.
> - Removes the explicit cache-initialization step from executables and tests.
> - Avoids premature initialization of unrelated device types.
> - Uses static storage: no allocated list nodes and no registry cleanup.
> - Does not require ordering between target constructors.
> 
> ### Constraints
> 
> - Constructors must only register metadata, not enumerate or initialize
>    QOM classes.
> - Consumers must run after startup constructors have completed.
> - Each registration node must be inserted exactly once.
> - Registry order must not be treated as a meaningful target ordering.
> - This simple design assumes compiled-in targets; runtime loading or
>    unloading would require additional lifecycle handling.
> 
> ## Comparison
> 
> | Aspect | QOM class cache | Static constructor registry |
> |---|---|---|
> | Discovery mechanism | QOM enumeration | Direct metadata registration |
> | Explicit startup initialization | Required | Not required |
> | Heap allocation for list nodes | Yes | No |
> | Cleanup policy | Required if releasing the cache | No registry cleanup |
> | Dependency on QOM initialization | Yes | No |
> | Registration-order sensitivity | Avoided through explicit sequencing
> | Avoided by consuming after constructors |
> | Late target registration | Cache needs updating | Requires a defined
> runtime registration policy |
> 
> ## Recommendation
> 
> Prefer the constructor-populated registry with statically allocated nodes.
> 
> `TargetInfo` describes the binary's compiled-in capabilities. Accessing
> that metadata should not require initializing the device model or
> maintaining an allocated cache of QOM classes.
> 
> The QOM cache fixes the immediate failure, but introduces an additional
> startup contract and ownership policy. A static constructor registry
> removes the underlying dependency and avoids heap allocation for the
> registry itself.
>

I will politely say one last time (and ignore this in the future): 
please do not copy paste AI summary to motivate any kind of design.
Also, please do not post inline patches. In case you would like to 
develop an idea, send a minimal series (with one or two patches) 
presenting the concept and implementation, it's more efficient for 
collaboration.

Regards,
Pierrick

