Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C78FCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYvs-00079l-Nq; Mon, 08 Sep 2025 06:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvq-00077b-OY
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:06 -0400
Received: from p-east1-cluster3-host10-snip4-10.eps.apple.com ([57.103.91.231]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYva-0001SI-F6
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:06 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 31A941800169; Mon,  8 Sep 2025 10:16:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=gj9ml0/2lblHAxAhDYnyGNFn4jVdTh3IeNEmfEK8+k0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=GB7M/E/DP8/SdOCoNGe0GXixz1rcaaw4l9ttOZ92i3BJTW7mspuAxCR0D0SsxAi2gfmB2DltBF8apK3XxLTSyD2yf3jZ4BFrOj3IZUuHBMqqLSvpKjySQdu3P76O2lyDZAqUGALnBfrxA+Y0R+3TKJGifRMlENxw5wrLW5lYUJlg2DenY5EOVR6f+9acoFPFo+snB8g/1UuQI1pweV93nuEfewPVVoehyHRt9ezM+YWlRP8Aqau8dvftQ2Z22MpJsnJGu2v+3nrOlAd+Vs2j56AHgTYUIj5b1wDDnyIr+dEqXwD+F/5wbO8qHzMHPLddBXlgXgb8zz7kpCfYq/UbUA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 1A0B91801CA4; Mon,  8 Sep 2025 10:16:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 09/24] target/arm/hvf: Mention hvf_sync_vtimer() must run
 on vCPU thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-10-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:16:33 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86BC1B89-31B0-43B7-ADBB-947A0DEEDFDD@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-10-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: P8HZrt2TBpitYq8EDfJIN2i987X5gRq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfXzQ84NUvAnCeu
 /mCyPdKuuM2PPX4qTS6UygQ0Kp1CiffIli5Jewnuj7NRN0pJjT5ufkDsggRbOpBY1024f9A39r3
 XxtLalZoXG/nmU3Ruz4mnyzGyh9QACCefllOH38tRSZf24epaxtfgIiv7/el8OrINzK5Hy3JNNp
 Juk5+M8Rmu2wNHxA8TdsGTEe6plNYx7mfHAxEqnP5sZWHuR1SHYvRKG8jrdpvblKdpCcjnL/oSw
 MIppBfCVzYPOrCuuL4A0GSsS1UvSEyMRhviYY/+GWi3mNpJSXXgcWntxLuXcqjL18uG33KOGE=
X-Proofpoint-ORIG-GUID: P8HZrt2TBpitYq8EDfJIN2i987X5gRq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=955 phishscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABNqm1MHQKcjvdkNdVHH3MhcJVL+94dtfZZ3MZnQ+ws3LTMPyAKyIld2zFSHz68Neq/tFfNkTBO1hejLXILAPXw1cMgJDgvsi7DHKuksu3B7QUr3Sg0ozcBvJprcyRLCKKRM3Xhn6/Ux5c7ao5FxUrEdaF4goGNx0kf8YvXCHSKNpLrI9ys2y6tB9I8yxi7Cne9hgbmZc1xhjcCpefFgD8nhjZtQyQpbE5pILi9Jws+Cq7JviNWvHeEWVKJGsPhS2kyRNx/0Sb3CEKekm7CSxp1OSJHKd+L9H0sERGYZBlD61B39o3JRwPfjJO6pjn2yfSMsVuma6B3TxhPs6fx2kVatySwzXmadYVR4Cne00Fjhaqb5lp+d82io9LVNbjXjT8on8oRTmwOzrQoiXE8Hj7FbDUC4oO0LsxiqphQ/141rrgpYD4/tCaHWq7WmkZdSLQnguodV3q7Sx+Xe0RSOsgkq+iQz8CsE8EauWtnD/hok7IGlQH+33Wu9eOXD1Y5QVlmDqxf32gR1R0b8U7W9unQhZV5w/KAecHNYP8rCv5PiShwOIcdowm8sDXi6kfpvdl239RF9uwvwafrw0NLuMSs+wmWs/FQDGGy5KSwmCAoQBlrht+6NpN2OpReohnyBj2jIWFRVJDQzcFf/AB4HvmomR+F7m7ynKxfTxNcVaRUUrwvsWDyiDUrbHB1IlWij2+o1E8migjjHcMROZ5afluwy8Qxzn2fSLN
Received-SPF: pass client-ip=57.103.91.231; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Since hvf_sync_vtimer() calls hv_vcpu_get_sys_reg(),
> which must run on a vCPU, it also must. Mention it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

