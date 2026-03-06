Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B38DF513F8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMjT-0004c0-CD; Thu, 05 Mar 2026 23:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMjS-0004bP-76
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:24:10 -0500
Received: from p-west3-cluster1-host4-snip4-10.eps.apple.com ([57.103.73.171]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMjQ-00032H-KW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:24:09 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPS id
 72DF418000BE; Fri,  6 Mar 2026 04:24:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772771047; x=1775363047;
 bh=ocQMUgh+diLfoU7tFyCqk/f6sIS3JWrRRntzf1eKfYM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=HHlildU/guKnTAcThDnRWMTXm6ij2af9dl0CoYPXbOh6qXbwaof1bxMPzjchozLImu5vcH5J8+q+Sec+iOKZSn4/L2n13UDdS2p/0C3YQVn0g/Vq1MxiGlf2Rq8mwxPx437fztwfl2hjkTiGeWdMUWIgAY1c24fsE3wwJ5lZEM7QX5865H18wjkiOS9uBpI+OEs/Fpn5WuAF0y8QUqlaJ3APgbbK840J4czcu9pjwE6hwS4hRzdsrrzAk0VcJnNtiditCNZ5EFQSlJx959WMkrw9wp/PDxbcgFbQ9rjXw1NGRPteYuAxYpXr9UExdiprLsld2l7CIPj5JG1gCVP9dA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPSA id
 057F5180019D; Fri,  6 Mar 2026 04:24:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v11 00/12] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <adbc2d78-bb8f-4ec8-a6de-29ac5617ebb0@linaro.org>
Date: Fri, 6 Mar 2026 05:23:50 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D8111BD-283E-4142-84A5-E9ED86598A40@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <0BFFD4B5-6B69-4F75-B329-5C429E65532C@unpredictable.fr>
 <1a23f69f-fba4-4f7c-9679-d06ad65be1d0@linaro.org>
 <adbc2d78-bb8f-4ec8-a6de-29ac5617ebb0@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=R9oO2NRX c=1 sm=1 tr=0 ts=69aa56e6
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=lAH_Zx9sSwNqvdQjkb0A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: C-b7FK0btf3KW0ER0mA1r3N-ikQVulVC
X-Proofpoint-ORIG-GUID: C-b7FK0btf3KW0ER0mA1r3N-ikQVulVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOSBTYWx0ZWRfXx/I0WM+YTTW3
 LMYCO1lJE+HlWneCZLEFomwXxbeuTJgCCVd0n5LfV/ZD+x544YCf8PGWKNpShgKKKrY3H/T6K3y
 UGAM30u77Ij7JeUZzUDaYWabdNcQeR0NR7e3vuaIWwH7Gu8J2b87ei1Y4bL3R4G4+lq0nDN0KG3
 4VqVz8xeUYyb5VMgKuLNG3aC5zsJV+2LiIa+PxGr7JzeTS/W1hqVjQHCyc3RTAJpMBnpgKaAzJ7
 /1hSVxMHaYMgApeGkphwygGqJVFdlTj4IO8eMeYR+av3SYHmbq6u1wmsWaNmPNLvk5sr01KjKB/
 5pz42aLKYNPHS8fNwjawYVkfrG+oAzd/Ncp8gSydIox6hA2EE7XtCOqwbRfXss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=828
 clxscore=1030 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060039
X-JNJ: AAAAAAABMW82bw5IZJF3nl4kKBuakQTVmUybmHk2qI9txo1eTtkQaOvwaNNAwFpXFsZFyXGuyF/CEYFWttdMnPy3b82PzBU83BwVvUBbnkCYmxNgDJcwJeHPvTpuSNOqTWZq/0EKnSNDxLLRG5CjZU/CVFcm7O+rF7EgZytAu0gwpV99riNbYFnMVjwjPJ87mxK7B23gBOpeC7JbJOSU9PkqIbVMZoSUwYeLLgkD3vNcoHw4eptP++zXBSbO2lNHke1eXBYdjBDxVDcJso/l9dMS8CLNIW1xVsymgCu8tzzI/IftA59jsD9rRHHXSFHxj+H2ylP0VckAR+9HZrInDXd73hMUSbiU/hFhLKnfW9kHjyVI6y6UznbGNltb05IRVjowqwjijxGciKG1E5VsfBoGSe250dJJGgBvSNWM3acTu0ifoyAOKUmaSOkfiYGz51m5Um1t1uM9vknrph9VlZEEtzyEQZqyGBhcEtFkwbf0+loMtKUciWDHywe9MiSpOlm+KBrjU6tJ+ZR3CkAHmglUCiVkdo1wIEtKuZyUuBErxhqygZTIJU7cslevJgc/OGTgfZBA8+xeZQp4Egbrly1NEEZvyQbZg/5rHvxk9kARyYppAtNP3e0NM4XvS2/XRiFcd+MwYHMsuOhRzlkkSZcfZm1+Ws0qBGmSItVUffHzt8LxJTg5USolufdPE4GIdhmxoQ9CKRuqxf8FLMOzpiTQJW130kYlGo3wwOUrJw3BHbDE/CKQ5S9Q8B0f+hy/zmeUF1z5iXmW0MyRTiDzLI1rWD0=
Received-SPF: pass client-ip=57.103.73.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 5. Mar 2026, at 23:09, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 5/3/26 17:48, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/3/26 02:34, Mohamed Mediouni wrote:
>>>=20
>>>> On 28. Feb 2026, at 23:08, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>=20
>>>> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and- =
nested
>>>> (tag for this submission: hvf-irqchip-and-nested-v11)
>>>>=20
>>>> This series adds supports for nested virtualisation when using HVF =
on arm64 Macs.
>>>>=20
>>>> Reviews would be very welcome :-) It's maybe a bit unlikely that =
this will make
>>>> it to QEMU 11.0 I might as well try.
>>>>=20
>>>=20
>>> The patches remaining for review:
>>>=20
>>> 1, 2, 3, 4, 5, 8, 10, 12
>=20
> Series fully reviewed! Hopefully it still applies on /master.
>=20
Hello,

It does apply on master but not together with Manos Pitsidianakis=E2=80=99=
s SME2 support patches.

Sent over a new revision with those patches at the start of the series =
and then the nested virt patchset taking them into account.

The patch modified was "hvf: sync registers used at EL2" and a new patch =
is added: "hvf: arm: SME2 availability fixes=E2=80=9D


