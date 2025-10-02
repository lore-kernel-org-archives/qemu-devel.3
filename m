Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC2ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Lwk-0000of-1t; Thu, 02 Oct 2025 12:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v4Lwg-0000nW-JG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 12:14:18 -0400
Received: from p-east3-cluster3-host2-snip4-10.eps.apple.com ([57.103.86.23]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v4LwQ-0000wi-SE
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 12:14:17 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPS id
 E84EA1803CCB; Thu,  2 Oct 2025 16:13:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Ro0Hh41El+RwH7tapGax5J9ZWB+boF9rFjySHs6PHW4=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=HvM5m7VJWYXtT8RRoD1ILEhqeMxEm7/8P3sV+POyjgpAtNj50A+LpuI637UooeqQpJfxVpGIahQwf2kYyAymHvdpbDjDn0pA+NVID/nzobduFQ3p/CX/ETqrbInZcboIr/Akzvdo973P3o+2Ulu3/NWkYmotjrc/gRjpQIGVEhx8xcu+tER8qNTff05EYStHkl9Tq4OXVnn2iwRhpxEosZ/gELJFxsmof2fze1Obstt/kQN3SnZRA5TLTZr7GH72IcMaJCDjkeSu0jDNByf8Bj6fhiS555Sfq60Hhz/whvH0RoXdOoVDb0yAnmptUWWHLcvdUfAwa9esJxbSGQqWTA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPSA id
 D92061804029; Thu,  2 Oct 2025 16:10:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <C8651AA3-5732-43F8-BDDD-9FE4EAEDE72A@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D120DC19-C3F3-4F88-B029-FCEA406624F8"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Date: Thu, 2 Oct 2025 18:10:28 +0200
In-Reply-To: <aN6b6HcTFo/4JEa4@example.com>
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
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
 <aN5Bjlf/xhsEHDNb@example.com>
 <3D0B6481-BA86-4CCE-8A51-63840A29F649@unpredictable.fr>
 <aN6b6HcTFo/4JEa4@example.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-ORIG-GUID: HEfMIrdluKaojs9WjcXBd9gK12UZiDMr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDEzOCBTYWx0ZWRfX1lhcwZF8hjwh
 sijmxGmBOAabLhIDn+FZpmR2Tl8H4ufK5dRs/n8U4OIrrLBAWLU3235pYSB9gdo2ufk8jcEgV0A
 TcdtGcaUDS6+f9nHiy8su3jGXD2HXgLTUWV+gOKgRp9iOCp6p4TuZGtDmzOi7GcyMOXjRe6XVAa
 Ba1fienRpkL2fbar2hO0pCV8yy4JtIZZpw/1dEUWDgep3xSY8tkG9p05uzfYurLIeHGNtN/4c25
 cX1ZawIEaPkfSlLqqEfBnkGgrhRNULB3d2NAZaMh5RFWs9pEV9vMvX339NobsgnB694YB4mIQ=
X-Proofpoint-GUID: HEfMIrdluKaojs9WjcXBd9gK12UZiDMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1030 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510020138
X-JNJ: AAAAAAABPATUja0JNi0Ibj5sYGzLXhNgQoTDNLmfXGSBT1Zh8eQLqyD49NqZNMdMLio/gpWeDcL9huUbaYanyL/FiTCwWlGMk+KKCCfIFPfnl85cTgkvo2NAdGwjqsRJf143YV7kEPJqeWugiQ4NC8Q4ECfQto0SY1TalKCGTj14Vc/bpBNgcpW3aVtDftR9MbVnGv5yEzBmC05dIjjAuscO4w6yTUbDMw74lNRcv7FGPYSvtWKeaLXM+I2TEC0JviMktLNORRJN3ve6zdyFgL/ms8UWURRVDOcqJ/88ZRdkslma+jXsPQi+9iPIxo7YP0O8jCyjIG3TnwHUnsLHnK674jYvT76ju1GcTKwDsslLnemA1zijCXg8LbI5XWj/o+poOFhQjSzlAJeln0MLKaghUoP/S8M6UFJAqQopp8mZVmZTXSiC9vHWLeCcqnY3UeHahWR9S3SUGTa94kH8YKaPA65zixtznz6sSKqV/RrL/sABqLnZdfP8j3xrThxb2nvxUu18M3Z/dKp21Qh/saubNLklTyS71sR1a1DxKc4V/b3qDV84Zrfa1JS1QgptZSgFp/5DpdKsazQ8q2PPhLBWbKqaoWz+b/ncZ1Zkl6e7BWkO16PLfn1oGCxodD71TRMlYGWbI4GnBo7zErd50TlJ1QgQuuL+KvyYfdPU29iM+Bzp0lIC3SD3KFidGlGyGy9Zo6cJwNUVV9w8QICxge4Iow/K8F43J6lXP9gmV1M0PIJck58S2o9jL208+eKtwsyEz5F5MN6M3BJAlRi27lPEBkmpztzshHSYfnj6DSx1+j0G6NTlVCIfn0pqWneAjZT3f7i8vodx+KV/5fy/FGK9O/pzih8cJzDVqZfNRAOK9rniZhuyJo/hhl6nBWynB2VRXZssWZgk6++eMx4UOqJxDglVMRrPi+o3fvseTaTNzeke
Received-SPF: pass client-ip=57.103.86.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_D120DC19-C3F3-4F88-B029-FCEA406624F8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 2. Oct 2025, at 17:36, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> If I understand correctly, your suggestion is to run HyperV as a =
nested
> hypervisor inside a QEMU VM (with KVM accel) on the CI machine that =
runs
> on on baremetal/L0? (mshv-on-kvm)

Yes. I=E2=80=99ve been playing around with that configuration using =
cloud-hypervisor
on an AMD Zen 4 host and it works fine.

Thanks,=

--Apple-Mail=_D120DC19-C3F3-4F88-B029-FCEA406624F8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 2. Oct 2025, at 17:36, Magnus Kulke =
&lt;magnuskulke@linux.microsoft.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">If I =
understand correctly, your suggestion is to run HyperV as a =
nested</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">hypervisor inside a QEMU =
VM (with KVM accel) on the CI machine that runs</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">on on baremetal/L0? (mshv-on-kvm)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote></div><br><div>Yes. I=E2=80=99ve been playing =
around with that configuration using cloud-hypervisor</div><div>on an =
AMD Zen 4 host and it works =
fine.</div><div><br></div><div>Thanks,</div></body></html>=

--Apple-Mail=_D120DC19-C3F3-4F88-B029-FCEA406624F8--

