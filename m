Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5672CD3F09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVFM-0006p6-3m; Thu, 29 Jan 2026 11:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlVFK-0006oZ-Ax
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:51:54 -0500
Received: from p-west1-cluster1-host3-snip4-7.eps.apple.com ([57.103.64.110]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlVFI-0007fX-Ds
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:51:54 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPS id
 05E96180048D; Thu, 29 Jan 2026 16:51:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769705510; x=1772297510;
 bh=ejSWa1sXG4fWH66vJ41KRLnie3I3EyyhZRjof9W6CgQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=I6si2mNZ3roPWQcBdHYJiF9lo6cwspOhnM21zcwteUpytcERP4goaWbebSvGxEIsKXRAXBIJp9QUklJSrCwsWVoW9cafemuGkNoBrKPh1SKzD7/+UJzuU/siLesxJjBwsBvg2+2YS7drNDe6j/YF00uY4yyUXBRavvHtDHcU/N4c5xc4u7eeaJqQaVJZLOtE9UopzhL9PD8eN2y2DdfeC1mur5l4hSnRDskp5rm+8hR8ZJBgx+G+MO6WZ7inP+MpAvg+dIMTAdQQV8Jhfqhtdd2hMiowTvSoHahVaP9tzfXYv6X5a5d/Rn2TfquowdrI5PqcHatb1mkKAnlxoTVmiw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPSA id
 453D11800990; Thu, 29 Jan 2026 16:51:41 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v18 13/22] whpx: interrupt controller support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA_+o2BRGPjk=++2pkZpN62yPKRhy4sx+7kSvXcee5ofqg@mail.gmail.com>
Date: Thu, 29 Jan 2026 17:51:29 +0100
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D302D4EE-8E69-4FED-BD31-E3A0D82C62EE@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-14-mohamed@unpredictable.fr>
 <CAFEAcA_+o2BRGPjk=++2pkZpN62yPKRhy4sx+7kSvXcee5ofqg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExOCBTYWx0ZWRfX5YA9Mt8L6Gai
 CaoxImYe5JvB6r4biIInEopKMisKEZy7cx9H4r5i2ySFIT96LC6NBZ4Hy0yHVDqullu8CGzOuKq
 iG5ZV6dS/dhhtOM/fXadVds0loXzg0UQJgVaVA7OX0kvI0mKDi9mE7RpLtTnvXBMmA0lQSUjm21
 F04Lo80k4KZEjRU95TkK/tntyjvm4CepB11WI3Rma8k72s+zE1rSsXmbl/+YDM5z7BQsAmp0ceP
 l7izQ1fXYy4mUHQtoXv0DeKIkipUBl6tB2e/e91XD6lqzLrpkM+TYo/wt2my+/jobZADXwcqQFe
 TwBi+YWXaMjIF8KkwUldSdE5h6VUpCz6LzlbP/Q6NxSvto8Q32Ok1hDjO1Kt+s=
X-Authority-Info-Out: v=2.4 cv=FqYIPmrq c=1 sm=1 tr=0 ts=697b9024
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QDk9sNPcX2z11vPKvYsA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6ElEsR5sPjbb6vtrBhw5dOtaISkL2oD6
X-Proofpoint-ORIG-GUID: 6ElEsR5sPjbb6vtrBhw5dOtaISkL2oD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=922
 clxscore=1030 spamscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290118
X-JNJ: AAAAAAABYJ0pt5Sb1cxEp+zv1/he5LW4g01JwrJjOWM7cUjAX3zIXGKBhbPy4RV6hXb4lWVPyUU9KutpjWoERZmW9o3K9pLiZJxQuArrt1FTl/ZwsbJQDSUjVqdimH5Ka4llxeH8ftSTR5uQd+ymR5EMxUYJpNwb4xVZP07aMcIuVFYO/rumh3DF3LTLAoqiGPsK+vv/EGvogMzjMWNXUDrnm6oJpXmVZiDNHnrXy/8hjIsntjGo4y+1iJOFBFpQ5hAO9s047YwTV+TyU1qmnNj/zEnm2dmR/bWgb3SUVnI8dXRuf2notGvHotVr7OVGSEY8Fs9y8Rdvbnq7Vs563COUnl0crdnC0ylMp7RBJ667qovSsG91DgSeZ/Q9XhDbPYJghjP0vcukYLwkXfQ/YNqF+fGwcxrYZbefGyszg9bB4vhwdEJ0T288nP7TH8U4vaOnFM+FwuQ9w0aepHeEgRp2K5zex6QtDxBiFP/PvGF7TWF1nUO5nahacI63mcFJ/TTH4+mibRT2ZGYk+D9kxwmQnzTkzfAI3oNDzZg6YjvhzXdijypswqi0SSqS9mU522XceWtOnn2fHpn6C3m1mrPckrUDUpw6/J6tnfxI+ZBW44A9ZG7jTflCMkDfzXtavGCi5+l1TZTkrVBqlIcpBxRcn/RtPkcEwZqOeHSj9YkbESScz9QraVuOk795In2w9mzVrDHJYKSpDIZrmDfhJkZMPnHpSBdV93BeAw2GhAt5YRYaQH42YF6grdtj7XFE4TaDqkFZU/EatxVC23+YkKfKGNF7FiKPK+FBMBCj5TyAcwbSsm7Kh7Blq8EuI84JDOSzDK0QQwHXtpYxjRoY+qTeAJmpUT+jVeJgxG5kkfmGBeuVHt3+rzkMCphINpDRFXzbBISKyf1avx20YOuUa3JUVw==
Received-SPF: pass client-ip=57.103.64.110;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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



> On 29. Jan 2026, at 16:28, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 27 Jan 2026 at 18:29, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
>=20
>=20
>> @@ -2143,6 +2146,9 @@ static void =
finalize_msi_controller(VirtMachineState *vms)
>>         }
>>     }
>>     if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_AUTO) {
>> +        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
>> +            vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>> +        }
>=20
> This looks like it ought to be an "else if" or some other
> construct so we don't fall through into the logic below --
> if we've decided we definitely want a GICV2M we can stop
> making decisions about how to set vms->msi_controller.
Would just doing a return; be a right way to deal with this, or =
converting to case?

Thank you,
-Mohamed
>>         if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>>             vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>>         }
>=20
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> thanks
> -- PMM


