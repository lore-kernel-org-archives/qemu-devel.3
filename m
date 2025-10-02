Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC06CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4K0n-0000im-Qj; Thu, 02 Oct 2025 10:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v4K0k-0000hO-6k
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:10:22 -0400
Received: from p-east3-cluster7-host1-snip4-10.eps.apple.com ([57.103.84.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v4K0X-0008Dk-2s
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:10:20 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 DDF7D180026F; Thu,  2 Oct 2025 14:09:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=EuGsZTr1EuGqL8ZRssUy33gEv030KKsk/7nvj1evTAQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=aJY/2Ohg7bJ2+ZlvUeaD0CIr473H6/QtvgHJvvNFpJSOsUyZqLPxKIzqTVQoLB63aYRjD9KaEpAptdeLrR6P3hDCSiEI0MmYBr2qyQYqtzLhydEHjz72LXk9c8POsEFRlhmHDwrgBl+hRfy1qyFuf5hz9Rsohq6XofHw7OBsNL9gKygGqBXSV/louzE25KMONDwjn18B9JKQV1VHguTaamowkdQwfRtZ+ANrPgn/hP3feFhK9OICalq+Qk/rwTaqO/nK8yP9e//Zr9NawfoFgey4MlaNUwfMMrBNJYc4RQdbq6V01bzC9sI5wW1h12kYPSpD/FdbLRA6keDAAOts7w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 33FB51800257; Thu,  2 Oct 2025 14:07:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <aN5Bjlf/xhsEHDNb@example.com>
Date: Thu, 2 Oct 2025 16:07:39 +0200
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D0B6481-BA86-4CCE-8A51-63840A29F649@unpredictable.fr>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
 <aN5Bjlf/xhsEHDNb@example.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDEyMCBTYWx0ZWRfX8vKPRRTI0s3h
 3/DW/bwMehrYE5EX09OcO4L52QjHRkI6j95NiPGhk57gJXFek/EFqDq6Di5VxSMrETZ7gmEwnIT
 ySRaCB9cLMtJbNwFyfT9isvfCkzONVrkPorztTs8fcTo1NTjBJNpfPaTxYLGeBTRhLk0jXHjjj0
 G9sGahQvcEcCOV9Dn68rYBCvcUfbo+cGX9kEhGRKLj/RU2CAZRbErQ1HZOzXCscJK4tcHV7MJm+
 oDVfn+T4TquQK9c/7HaFP6AL5VKcmwhFh0G+Hxa9M2RTldAM6CUytRxccdkHRfAWRRJqugMiw=
X-Proofpoint-ORIG-GUID: I2awVdwbWVaQx1J1iIHozc6wxnckbbd5
X-Proofpoint-GUID: I2awVdwbWVaQx1J1iIHozc6wxnckbbd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510020120
X-JNJ: AAAAAAAB5BvIm36p3bhthDRZpqvEgno5pH+58zfd11FT86zRxd0fACd94tgb3a3eLAcnZ0cBoRFOPxhTBne9/Sv2/Eti/A7FFR6kdNnZtsRjjfAE9d84LeoeMrPpt/7ULDUzEPcmRBK3vBlILi9cNGu6YWVAoHIYPJm/psXhy7+CqYl71ruIvPHRihj6zjG3ZtR6NvIxcdBmvacSXu1GEnIO8aXrITtPa7y7wXW9KLll5IGbDFR7/j9uNy5hjdaLnAL3Dhz/Qxbbec19Tka0jVTkQE5Dsxwmv+Mp6NH2x9tL4h+DE9nXR38Vyj3bfTj9JFBkVt6XY2h+CRbrulHxb77GDd1Pe+Z48dAD9+pllXYT98y5Wh6GEhbpm+1F1XAgDrQwHeiO4i7edsVRhwy0te2t2UfwYgqq51NES8rNLeSB9Wb5ihePYku6q4kxhVeqTSM1X9HO0tbawDb+8S+I8BvDVxrf48XUPTTmxZUTFbKVBZDJrXarQGQhnKnuSEvEcT5sFezMB/PSgtcx31yUXGuWccUn4JyK4DOdLB8Ju06IsHFmi8usZNd8Df8fOVl0cU6ZGZDvUydGtTbIEi8WOrlWgUbenKFR4VCoT+LB3VBXjyxmG+R3dKvQv04aBi018aDJ9489ckK+IHNizOjkc55H0BVkJ4cZ7hELBWkC7IkbpNyLst5swYge9IFj2fEnUQ5oI5HOB+nUdo8yxGrtG0AREUDIEZCXyCYm+ZNqoo9jLHkUCjENr4GWBBcHKRyRfyQQ14/uYF2LYGC4anpaf0K7wfExI7iLye3R07R0imsv5lH2I++qqSonsOl3uMv0fU5LLVN544a2xHJsXNuX4ROXeCI73ZOizfduuk188xL9V2n6qgR41b8moFN1u6lwdKUmTSwWvLOJiCSDFdY4JEHZgoZUuDllyElWIw+3A0HGEPOHjbhQp7kLZU0L6MW7
Received-SPF: pass client-ip=57.103.84.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 2. Oct 2025, at 11:10, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> On Thu, Oct 02, 2025 at 10:30:56AM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> Due to my generic work on accelerators, I'll have to refactor these
>> patches. Obviously I don't want to break your implementation! Can
>> you add some (functional?) tests? Ideally we should be running
>> tests on our CI to ensure code doesn't bitrot.
>>=20
>> Regards,
>>=20
>> Phil.
>=20
> Hey Phil,
>=20
> yes, that's a good point. I assume for functional tests we
> will face the challenge those will require external infra, because
> eventually there needs to be a HyperV Hypervisor running somewhere.
Worth noting that x86_64 MSHV on Linux is available to the public as =
part of Azure Linux,
and runs inside of a Qemu VM just fine. (with the catch that MBEC =
isn=E2=80=99t currently emulated by KVM)

Perhaps having an Azure Linux instance in CI could be the right thing to =
do?

Thank you,

> Is there any precedent/prior art in QEMU (e.g. for HVF or WHPX) that =
we
> could follow?
>=20
> FWIW, in smoke tests for the patch series I've been using a nested
> HyperV hypervisor that is shipped as dll and made available as UEFI
> protocol to the MSHV driver (I _think_ that is how it works, I'm a
> bit out of my depth here since I don't know how those things are
> glued together in detail).
>=20
> For reference: https://github.com/mkulke/qemu/actions/runs/18187719634
>=20
> There will be other virt topologies supported by the MSHV driver and
> the nested option is not upstreamed to mainline yet. However, from
> QEMU's perspective those topologies do not matter, they share the same
> ABI of the kernel driver.
>=20
> So we could do something similar, provide/maintain a VM on Azure with =
a
> similar nested HyperV hypervisor configuration that we can used for
> testing. Would this make sense?
>=20
> Best,
>=20
> magnus
>=20


