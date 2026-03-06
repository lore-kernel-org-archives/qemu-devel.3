Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9527EFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXXv-0004sf-Cn; Fri, 06 Mar 2026 10:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXXp-0004rN-QT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:56:55 -0500
Received: from qs-2003f-snip4-1.eps.apple.com ([57.103.86.54]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXXn-0003YD-E8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:56:53 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-3 (Postfix) with ESMTPS id
 D75521800166; Fri,  6 Mar 2026 15:56:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772812610; x=1775404610;
 bh=IfYkcp9EAhepLsIpPiXzWQXumTCtnGsOnxuY3ZnqEVs=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=HiTz5MWwXg1KCQXlJH+vzX5IbOklU9ia/M+FmZOdm1qGR58KdQLW3XfvuzJAR6RSqdhoZ4+6ffjlgaArmCx7OntptJ21YvUTgG7WSY7tNtogVfczrnVfBEUrOdJM1FBZDpYYftQH3jXivqT8TdNfoCPjxKSfDdNIbOztvU4EPkrB35w66AgRz2RGCnawNmapG1WaZQKyxxsMxH/Rj6/57FcOB/E7ifs4HJaK/07kB79cw4zhVaMOcFhy8bsW3wDDimVMC9jYPANIhs1RF72eITaQ3CT98cOvJ0EcYHlrrWH9uK7NeF46P/D/YKFDEkAA2mzRHkWvmcUuOkN7rZ54Jg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-3 (Postfix) with ESMTPSA id
 BE454180028B; Fri,  6 Mar 2026 15:56:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <7DC0F2E1-95DB-4E0A-B966-BF3B62205666@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_73C8D52A-DCEA-4272-8D01-1DCA3EE2122A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Fri, 6 Mar 2026 16:56:32 +0100
In-Reply-To: <83E62271-E3F8-432E-8499-D1D8D065B162@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
 <CAFEAcA8gB-36c1TvJSwJ0MkVMy5z_dqKpVY7KTJ-cMV5rAX1_w@mail.gmail.com>
 <83E62271-E3F8-432E-8499-D1D8D065B162@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: NCNQS3UUvedMbjAf-XVZ_A5RD_6jOoYK
X-Authority-Info-Out: v=2.4 cv=RKu+3oi+ c=1 sm=1 tr=0 ts=69aaf940
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=mUXXko0W7ALBaSRkzvcA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=cKB09DxWZWNP8g9OlwkA:9
 a=7Is0g2WZmGQuy_It:21 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1MSBTYWx0ZWRfXx5cIY+iT9W6d
 W01cvyASChxYIpfkxjgjV6hfK+hURGoUtEgulMjS+DhGnQnca3+K8Z678KLRduZPC7IedbINabn
 kINuSqJExl2rsNKc8JjwsTst2yzaSH8yfVc9JrTmTQh0yz7dtDObctiv4deAfWwuSBSyYQ3zOXi
 8z1udRXhwIjYMd2jQ7vWdXEiM0c65Fif0DvwWArma7XDbHQebTbLNA20OmRHL1F7FRVW+Qe3yww
 +unFwks1LbXurH9E/SC8rUq3UYOx8vpOoaVCgM5ZHquNrf/zv4phZ4Xm0Xvc7W61O3moUD6omKW
 uf7sJomjwHdFCAvm4rPqwjrV0SlDTwizOn8etfv7IMzOumErLnc1RLo3wvdrvk=
X-Proofpoint-GUID: NCNQS3UUvedMbjAf-XVZ_A5RD_6jOoYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1030 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060151
X-JNJ: AAAAAAAByPpaTZX5FbEn/Cheid49hFDu1kGg2Gz/Rqdfcf5LVXf22J8/eEoS/QkWqDgUuP8y0HUUivZSJUmWpdl5otDEGGU8yhhIPWxJqR9KrbCvY7G5vzSeFQEUhZsM4xupmLrzEiFWlp9cMl6iPJ2O9DSxRiacM43zESJAPqNeSIkfUvALQ0oAdp5Tzdc8FJM+afxmCH7HqAlUoV7Door7yJlQquGgPS+5jb/vZsWFVTyqE/dDiYmUqw8somL5lSfeqs/lNW5eHb4Vb9uuvSwihB7wpNtld3Tc3u2qDrCQpUSn2DW1wxG2M/i30hzn13lisC6T3RXo+Nobcg1xazyyRhXVLsUcIAGvSAzn6m0IjqD9YjHmz87MQaemORhhL5be2i0MOuJLAnYMk6aSL9RNcb4k3/oHGPgmlVWA87DneY2OuMcJzsiCj964JHAzxg1DBGr2SOgXEmXUgL9ES7kiB6uMcgUONR3PA9ONwCsbKuwboN2Y2TYN245trO6nuwhSHhnNLuBBQFDtQgrjiwUq+QQqyHJV0RAvWB47LKeWr1CIANV9oWwJOZwd4hHcR5jscnFr0428az8QcCHkc7VID7XWUgzCGCEaW2o6jTl1/jYctSekA7SZTNplzTegs1lx6zjmBOgCL0pgkO4P+3DnNxwJCaOMJ6k4/v4jXCwo0bTw8eYwgZb6Ra16Re90AKfIDKJQIqJeJq/IlPbPZH6QpTrQlhVSui3bjCptJ3UyJYQP1Qt0z67KLUU7IQGkGjHxhuCsXHCXpQWmJjsioQ==
Received-SPF: pass client-ip=57.103.86.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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


--Apple-Mail=_73C8D52A-DCEA-4272-8D01-1DCA3EE2122A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 6. Mar 2026, at 16:53, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 6. Mar 2026, at 16:44, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> On Fri, 6 Mar 2026 at 14:58, Peter Maydell <peter.maydell@linaro.org =
<mailto:peter.maydell@linaro.org>> wrote:
>>>=20
>>> On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>=20
>>>> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
>>>> (tag for this submission: hvf-irqchip-and-nested-v15)
>>>>=20
>>>> This series adds supports for nested virtualisation when using HVF =
on arm64 Macs.
>>>>=20
>>>> Reviews would be very welcome :-) It's maybe a bit unlikely that =
this will make
>>>> it to QEMU 11.0 I might as well try.
>>>>=20
>>>> The first two patches are from the SME enablement series and are =
present for the
>>>> series to be buildable on its own.
>>>=20
>>>=20
>>>=20
>>> Applied to target-arm.next, thanks.
>>=20
>> I'm afraid this failed to build in our gitlab CI job for macos:
>>=20
>> https://gitlab.com/qemu-project/qemu/-/jobs/13388426185
>>=20
>> In file included from ../target/arm/hvf/hvf.c:489:
>> ../target/arm/hvf/sysreg.c.inc:174:21: error: =
'HV_SYS_REG_CNTHCTL_EL2'
>> is only available on macOS 15.0 or newer
>> [-Werror,-Wunguarded-availability-new]
>> 174 | DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
>> | ^
>> =
/Applications/Xcode_16.1.app/Contents/Developer/Platforms/MacOSX.platform/=
Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hypervisor.framework/H=
eaders/hv_vcpu_types.h:312:5:
>> note: 'HV_SYS_REG_CNTHCTL_EL2' has been marked as being introduced in
>> macOS 15.0 here, but the deployment target is macOS 14.0.0
>> 312 | HV_SYS_REG_CNTHCTL_EL2 API_AVAILABLE(macos(15.0))
>> API_UNAVAILABLE(ios, tvos) =3D 0xe708,
>> | ^
>>=20
>> and similarly for other registers.
>>=20
>> I'm going to drop the last 4 patches from the series, which I hope =
will
>> fix the CI problems.
>>=20
>> =E2=80=94 PMM
> Hello,=20
>=20
> Will submit a new rev of the last 4 patches with a workaround for this =
then=E2=80=A6
>=20
> (Ugh @ compiler pragmas but there aren=E2=80=99t better choices =
unfortunately)
>=20
For reference, the workaround:

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 61ba5acce4..11ff74e4c7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -471,8 +471,14 @@ static const struct hvf_reg_match =
hvf_sme2_preg_match[] =3D {
  *
  * SME2 registers are guarded by a runtime availability attribute =
instead of a
  * compile-time def, so verify those at runtime in hvf_arch_init_vcpu() =
below.
+ *
+ * Nested virt registers are handled via a runtime check, so override =
the guarded
+ * availability check done by Clang.
  */
=20
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wunguarded-availability"
+
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID !=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 #define DEF_SYSREG_15_02(...)
@@ -494,6 +500,8 @@ static const struct hvf_reg_match =
hvf_sme2_preg_match[] =3D {
 #undef DEF_SYSREG_VGIC
 #undef DEF_SYSREG_VGIC_EL2
=20
+#pragma clang diagnostic pop
+
 #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
 #define DEF_SYSREG_15_02(...)
 #define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 =
=3D true},


--Apple-Mail=_73C8D52A-DCEA-4272-8D01-1DCA3EE2122A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 6. Mar 2026, at 16:53, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta http-equiv=3D"content-type"=
 content=3D"text/html; charset=3Dutf-8"><div style=3D"overflow-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: =
after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 6. Mar 2026, at 16:44, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Fri, 6 Mar 2026 at 14:58, Peter Maydell =
&lt;</span><a href=3D"mailto:peter.maydell@linaro.org" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">peter.maydell@linaro.org</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><br>On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:<br><blockquote =
type=3D"cite"><br>Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested<br>(tag for this submission: =
hvf-irqchip-and-nested-v15)<br><br>This series adds supports for nested =
virtualisation when using HVF on arm64 Macs.<br><br>Reviews would be =
very welcome :-) It's maybe a bit unlikely that this will make<br>it to =
QEMU 11.0 I might as well try.<br><br>The first two patches are from the =
SME enablement series and are present for the<br>series to be buildable =
on its own.<br></blockquote><br><br><br>Applied to target-arm.next, =
thanks.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I'm afraid this failed to build in our =
gitlab CI job for macos:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><a =
href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/13388426185" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://gitlab.com/qemu-project/qemu/-/jobs/13388426185</a><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">In file included from =
../target/arm/hvf/hvf.c:489:</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">../target/arm/hvf/sysreg.c.inc:174:21: =
error: 'HV_SYS_REG_CNTHCTL_EL2'</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">is only available on macOS 15.0 or =
newer</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">[-Werror,-Wunguarded-availability-new]</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">174 | =
DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">| ^</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">/Applications/Xcode_16.1.app/Contents/Developer/Platforms/Mac=
OSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hyperviso=
r.framework/Headers/hv_vcpu_types.h:312:5:</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">note: 'HV_SYS_REG_CNTHCTL_EL2' has been =
marked as being introduced in</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">macOS 15.0 here, but the deployment target =
is macOS 14.0.0</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">312 | HV_SYS_REG_CNTHCTL_EL2 =
API_AVAILABLE(macos(15.0))</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">API_UNAVAILABLE(ios, tvos) =3D =
0xe708,</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">| ^</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">and similarly for other =
registers.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I'm going to drop the last 4 patches from =
the series, which I hope will</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">fix the CI problems.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">=E2=80=94 =
PMM</span></div></blockquote>Hello,&nbsp;</div><div><br></div><div>Will =
submit a new rev of the last 4 patches with a workaround for this =
then=E2=80=A6</div><div><br></div><div>(Ugh @ compiler pragmas but there =
aren=E2=80=99t better choices =
unfortunately)</div><br></div></div></blockquote>For reference, the =
workaround:</div><div><br></div><div><div>diff --git =
a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c</div><div>index =
61ba5acce4..11ff74e4c7 100644</div><div>--- =
a/target/arm/hvf/hvf.c</div><div>+++ b/target/arm/hvf/hvf.c</div><div>@@ =
-471,8 +471,14 @@ static const struct hvf_reg_match =
hvf_sme2_preg_match[] =3D {</div><div>&nbsp; *</div><div>&nbsp; * SME2 =
registers are guarded by a runtime availability attribute instead of =
a</div><div>&nbsp; * compile-time def, so verify those at runtime in =
hvf_arch_init_vcpu() below.</div><div>+ *</div><div>+ * Nested virt =
registers are handled via a runtime check, so override the =
guarded</div><div>+ * availability check done by Clang.</div><div>&nbsp; =
*/</div><div>&nbsp;</div><div>+#pragma clang diagnostic =
push</div><div>+#pragma clang diagnostic ignored =
"-Wunguarded-availability"</div><div>+</div><div>&nbsp;#define =
DEF_SYSREG(HVF_ID, ...) \</div><div>&nbsp; =
&nbsp;QEMU_BUILD_BUG_ON(HVF_ID !=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));</div><div>&nbsp;#define =
DEF_SYSREG_15_02(...)</div><div>@@ -494,6 +500,8 @@ static const struct =
hvf_reg_match hvf_sme2_preg_match[] =3D {</div><div>&nbsp;#undef =
DEF_SYSREG_VGIC</div><div>&nbsp;#undef =
DEF_SYSREG_VGIC_EL2</div><div>&nbsp;</div><div>+#pragma clang diagnostic =
pop</div><div>+</div><div>&nbsp;#define DEF_SYSREG(HVF_ID, op0, op1, =
crn, crm, op2) &nbsp;{HVF_ID},</div><div>&nbsp;#define =
DEF_SYSREG_15_02(...)</div><div>&nbsp;#define DEF_SYSREG_EL2(HVF_ID, =
op0, op1, crn, crm, op2) &nbsp;{HVF_ID, .el2 =3D =
true},</div></div><br></body></html>=

--Apple-Mail=_73C8D52A-DCEA-4272-8D01-1DCA3EE2122A--

