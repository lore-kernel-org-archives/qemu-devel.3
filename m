Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E47F436B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDlRi-0002AM-Ql; Fri, 17 Apr 2026 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wDlRg-00029b-LL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:49:28 -0400
Received: from ci-2002g-snip4-6.eps.apple.com ([57.103.88.197]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wDlRe-0007mX-JG
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:49:28 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPS id
 9BF7F180012D; Fri, 17 Apr 2026 15:49:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776440964; x=1779032964;
 bh=tyD9mhE/T9CG+456liFm2c++DwX2i5ogTLg4TwJTozU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fUuw4i/8/qjrTBedc3+Lddp+3h5LW0Ul/DbjSbR7t8SNPouml4G6WOrRNOVHEUz9ZIhnkUhyvk2pEDNWGND+O6BZ4rcjaC9IbSNaqDh7leZ02EKQ/1qUwUEwqHSxcVSw6AJ+qHfaBv0c6nb0sWGeuyhg9a5RCdt1eFMX7/H2Slm1mEEKTvoU+EgQVtYSWtr5q2fj2B1+7Y8sOnCV9MWlPc1AivZk+2+MXuKTPXWLMupEgNfhIVketZuc6tCZ44y8dSX2CCpo458vyQmv82Agepcuuq0HuBbzVElzXM/Uok7G59WYtCyYEqkdAJx+zuTUpDPShf3Ve+U4dRuVh58WIg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPSA id
 18BDC18009CD; Fri, 17 Apr 2026 15:49:18 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH RFC v1 1/1] hw/s390x/ccw: Disable legacy virtio-pci by
 default (v11.1+)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260417154332.849664-2-jhkim@linux.ibm.com>
Date: Fri, 17 Apr 2026 17:49:06 +0200
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 cohuck@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <232BE8D6-20C3-466F-972C-62CA540B6459@unpredictable.fr>
References: <20260417154332.849664-1-jhkim@linux.ibm.com>
 <20260417154332.849664-2-jhkim@linux.ibm.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=U/qfzOru c=1 sm=1 tr=0 ts=69e25683
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=RPI9Y2ByLZF320QChDEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 8jd_0dzyxBdkuV_KYMqp-B0gr5uwUJPE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1OSBTYWx0ZWRfX+/SvKbbyEJ/M
 I8eqjlXDUlFeRaCwgS6BoWKJc6atb7WClL959MNysmSrFdYgyf8lkkwBL69VW77vEerXd6VhVmZ
 sWX36d1fhJS7lPbBPW7OjHl5o54oiriumNiJ9qwvor3k05Q3kLlp9360GGG9OSe1wPq+5wNlU3d
 1Yli1hYgAYJCZdHuIxy7W+PXGO5LlEK+ALCPirVuJEytDxOC/rJ81t5QMjhTrPJzdp84KqorRXU
 wCiUWd80tokyzWlFImuChw/LCcJOALaZRA6n8StsidVj+rckHugLWsibg7KXqQInIw60EzKEmBu
 n/Pmm5YRBwEZ6fhXxa3bCFORVilDMqhKa/O1eGruc9W++PZmdaMYMv6ZshA3B8=
X-Proofpoint-ORIG-GUID: 8jd_0dzyxBdkuV_KYMqp-B0gr5uwUJPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604170159
Received-SPF: pass client-ip=57.103.88.197;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 17. Apr 2026, at 17:43, Jaehoon Kim <jhkim@linux.ibm.com> wrote:
>=20
> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
> making I/O BARs unusable.
>=20
> However, when virtio-pci devices operate in transitional mode, QEMU
> unconditionally exposes the legacy interface via BAR0. This results in
> firmware warnings during PCI enumeration, such as:
>=20
>  pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
>=20
> even though BAR0 is never usable on the s390 kernel.
>=20
> Close this gap by disabling legacy virtio-pci support starting from
> machine version 11.1. This effectively makes virtio-pci devices
> non-transitional and prevents the creation of the unusable legacy I/O
> BAR.
>=20
> This introduces s390x-specific global compatibility properties that
> set disable-legacy=3Don as the default for virtio-pci devices. Machine
> versions v11.0 and earlier set disable-legacy=3Doff to maintain their
> original default behavior (legacy support enabled), ensuring VMs
> created with those versions continue to work identically.
>=20
> Users can override the default on the command line if needed:
>  - On v11.1+: -global virtio-pci.disable-legacy=3Doff (to enable =
legacy)
>  - On v11.0-: -global virtio-pci.disable-legacy=3Don (to disable =
legacy)
>=20
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> hw/s390x/s390-virtio-ccw.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index cc768daeb0..6fbea1e289 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -788,6 +788,18 @@ static void machine_set_loadparm(Object *obj, =
Visitor *v,
>     g_free(val);
> }
>=20
> +/*
> + * S390x-specific global compatibility properties.
> + *
> + * Set disable-legacy=3Don as the default for virtio-pci devices =
starting
> + * from v11.1. Machine versions v11.0 and earlier set =
disable-legacy=3Doff
> + * to maintain their original default behavior (legacy support =
enabled).
> + */
> +static GlobalProperty hw_compat_s390x[] =3D {
> +    { TYPE_VIRTIO_PCI, "disable-legacy", "on", .optional =3D true},
> +};
> +static const size_t hw_compat_s390x_len =3D =
G_N_ELEMENTS(hw_compat_s390x);
> +
> static void ccw_machine_class_init(ObjectClass *oc, const void *data)
> {
>     MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -878,6 +890,9 @@ static const TypeInfo ccw_machine_info =3D {
>         const void *data)                                              =
       \
>     {                                                                  =
       \
>         MachineClass *mc =3D MACHINE_CLASS(oc);                        =
         \
> +        /* Apply global s390x-wide default properties */              =
        \
> +        compat_props_add(mc->compat_props, hw_compat_s390x,           =
        \
> +                         hw_compat_s390x_len);                        =
        \
>         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);          =
       \
>         mc->desc =3D "Virtual s390x machine (version " =
MACHINE_VER_STR(__VA_ARGS__) ")"; \
>         mc->init =3D MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);     =
         \
> @@ -923,7 +938,15 @@ static void =
ccw_machine_11_0_instance_options(MachineState *machine)
>=20
> static void ccw_machine_11_0_class_options(MachineClass *mc)
> {
> +    /*
> +     * Preserve v11.0 and older version behavior:
> +     * keep legacy virtio-pci enabled.
> +     */
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
> +    };
>     ccw_machine_11_1_class_options(mc);
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>     compat_props_add(mc->compat_props, hw_compat_11_0, =
hw_compat_11_0_len);
> }
> DEFINE_CCW_MACHINE(11, 0);
> --=20
> 2.50.1
>=20
>=20


