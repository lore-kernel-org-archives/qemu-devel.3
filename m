Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6313CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 04:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz5xF-0003EY-36; Thu, 18 Sep 2025 00:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uz5xC-0003DU-5b
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 00:09:06 -0400
Received: from p-east3-cluster7-host10-snip4-3.eps.apple.com ([57.103.84.224]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uz5x8-0003c0-ML
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 00:09:05 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPS id
 2BA22180015E; Thu, 18 Sep 2025 04:08:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=udV516SdWbrPwHJMPOB/C2xrkdp6rpTtChM5TiAGGyc=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=aZh9q35t+ay/CjSmhZZWRSIQiQ4u2XrBVe9qFORaK/e/9vb/XGU+c/ugvq391C3exI9jXvUMV+Vl1FbT6OoOyu5Z790sNuw/c6Mku7iv3duVTvN4ZtHaMxMkuFhUeEb2JnI5NXLkT6uk9l87Dz+kC2CxS6hV4zA/mv9fnMVMwdyN+wxImCD7GKVug/v3i+fPMML+69IWOWCNbJIJiC4nZxjeMKOpYOiMfaw2mJhLiwjMnOMNmE77Lz++gtNJctzHnlh/WBL/zOxCi+9SkHiEW9R+Q48EXmTwD/gl/F8hr84U1OhXtn86ufCV8AuJWI9kyDM+j1XIxX+99eUPJMzh7g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPSA id
 76BE31800102; Thu, 18 Sep 2025 04:08:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <2F2C5711-E5FE-4748-9854-79C225FD916C@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_3CC3CB38-5A09-465D-A363-2886D92B0143"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v3 00/26] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Date: Thu, 18 Sep 2025 06:08:37 +0200
In-Reply-To: <20250911025906-mutt-send-email-mst@kernel.org>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250911025906-mutt-send-email-mst@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-GUID: rAQl0_wVxwI_noWPWrApQiJ9KMPkcYbM
X-Proofpoint-ORIG-GUID: rAQl0_wVxwI_noWPWrApQiJ9KMPkcYbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDAzNCBTYWx0ZWRfX6XjIktOy5ztu
 1aNG4WnP2HYPVBN3v31OF0amJ+8aT6d4j+wilbf74AX484T9f7j12o0mAvGh8IFj+kYK7tKXbeV
 LnlFAOqi0SPMqt/jPl0f46XMxuiclzakDNMJPG63vsCbF1oAmO5SPzEQOrlIPtOU0gm5+FZ7t4v
 vRY8YGeDb2Cb4usNvvnX0RywTDSDKrIAsRt6BCYUVLLSNXCe+rzEkA0wCWuiKL2prDtIYIjdNQ8
 racjw4F0bXWyVLFeLAty4ZZC8T+My05XAu1wqOi7z3Zpi/B3B7VlC5IsA5J0TEmNU7fZhTzyg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509180034
X-JNJ: AAAAAAABiZZA+cx8MYM0yWjXtkzJdzAhq5HXggMGVgie0ncQzX2WMM2PZEUAv1zSjNNH1ORGLFCaMDtTNexAi/4+LP7K6LtHJrRP8y1WtkZmPkOd4K/c2LcHVbcB+O5SE74C6Ya5tBnTw3zAvVQA+TzmhX2VOBi7UPV5/nDJKQHo1ZBF8IapGk928Jqfrqmnuy/aAp1MP0pSvUA0UyiQWZ3spmSMRUDX2QdYMutQsqawKv8x9VGphShsoeK+yxghM15QJBNE8E0b8t7u5JJDkcMRlB6c38evDIwuLTIGx0cEG0oYbhtafAX6wDcv921eNOnHkN4uz6hA+HC4JVMH/jp07ezfxFtBEfaogXSO5Bw5HBNstGEa/qaSeAAXsvSZje2gdwEGHK1AIyrYkRaRYcoRjzMVDZ0YxCdudy1TD7FDDs/X9LvT+6NL5PYaRN3NpKmD4peN1+WhChsqYSB7Fx78vmaoOiA67fU9+UqTlUABqXD5dgxRtCfqaBFBbmhAHvmJl5CXDsNdx4xYZzVmo8EpZp2tGin/6GB0FbCrgrHcR4mbVdYMWSbX3QCiQVS+RZXA5q6slfGrHJeIprazVH5NvsFZmA7uForh/lDHMJ8xnnKW+DZpP7i19zIQVK2oEPTaWSKF168wx/T79tdOE3bhKxmCUj8GVwVJrOkEoV+oTlGBMDpWI6XVLXDIVEmfCDS4rg8F0pr2CvIL9HrfZB2Bp1/ROcbJZiXyWMVFxzeNHgf6FFz1tYk+hLaDo6dvNF/xE6LWyhtfwEwO9G20zAwerzGlXaDG0Fog62pAx/uVJZ9J4vXrBrVArXJuSEOQuBo121gBHPcCOjA7UQsDchVjifGcGr5KYurC5dasz3zWjhcG4EotiEzuCMEJn/bIVx+s
Received-SPF: pass client-ip=57.103.84.224;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_3CC3CB38-5A09-465D-A363-2886D92B0143
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 11. Sep 2025, at 08:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> So regarding merging plans. Did you guys get in touch
> with Sunil? That's the easiest smoothest path, through
> an existing maintainer.


On that bit:

Didn=E2=80=99t submit this yet but this is coming in the next WHPX arm64 =
patch revision:

    MAINTAINERS: update maintainers for WHPX
   =20
    And add arm64 files.
   =20
    =46rom Pedro Barbuda (on Teams):
   =20
    > we meant to have that switched a while back. you can add me as the =
maintainer. Pedro Barbuda (pbarbuda@microsoft.com)
   =20
    Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

diff --git a/MAINTAINERS b/MAINTAINERS
index ece8624d01..6b1764ccf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -544,11 +544,14 @@ F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
=20
-WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+WHPX
+M: Pedro Barbuda <pbarbuda@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx_arm.h
+F: target/arm/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h=

--Apple-Mail=_3CC3CB38-5A09-465D-A363-2886D92B0143
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 11. Sep 2025, at 08:59, Michael S. Tsirkin =
&lt;mst@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">So =
regarding merging plans. Did you guys get in touch</span><br =
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
display: inline !important;">with Sunil? That's the easiest smoothest =
path, through</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">an existing =
maintainer.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote></div><div><br></div><div>On that =
bit:</div><div><br></div><div>Didn=E2=80=99t submit this yet but this is =
coming in the next WHPX arm64 patch =
revision:</div><div><br></div><div><div>&nbsp; &nbsp; MAINTAINERS: =
update maintainers for WHPX</div><div>&nbsp; =
&nbsp;&nbsp;</div><div>&nbsp; &nbsp; And add arm64 =
files.</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; =46rom =
Pedro Barbuda (on Teams):</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; =
&nbsp; &gt; we meant to have that switched a while back. you can add me =
as the maintainer. Pedro Barbuda =
(pbarbuda@microsoft.com)</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; =
&nbsp; Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;</div><div><br></div><div>diff --git =
a/MAINTAINERS b/MAINTAINERS</div><div>index ece8624d01..6b1764ccf0 =
100644</div><div>--- a/MAINTAINERS</div><div>+++ =
b/MAINTAINERS</div><div>@@ -544,11 +544,14 @@ F: =
accel/stubs/hvf-stub.c</div><div>&nbsp;F: =
include/system/hvf.h</div><div>&nbsp;F: =
include/system/hvf_int.h</div><div>&nbsp;</div><div>-WHPX =
CPUs</div><div>-M: Sunil Muthuswamy =
&lt;sunilmut@microsoft.com&gt;</div><div>+WHPX</div><div>+M: Pedro =
Barbuda &lt;pbarbuda@microsoft.com&gt;</div><div>+M: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;</div><div>&nbsp;S: =
Supported</div><div>&nbsp;F: accel/whpx/</div><div>&nbsp;F: =
target/i386/whpx/</div><div>+F: target/arm/whpx_arm.h</div><div>+F: =
target/arm/whpx/</div><div>&nbsp;F: =
accel/stubs/whpx-stub.c</div><div>&nbsp;F: =
include/system/whpx.h</div><div>&nbsp;F: =
include/system/whpx-accel-ops.h</div></div></body></html>=

--Apple-Mail=_3CC3CB38-5A09-465D-A363-2886D92B0143--

