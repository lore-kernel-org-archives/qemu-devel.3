Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C578CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYw4-0007GU-A0; Mon, 08 Sep 2025 06:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvt-0007Bs-Fc
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:09 -0400
Received: from p-east1-cluster7-host1-snip4-10.eps.apple.com ([57.103.88.13]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvg-0001TR-9c
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:08 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-1 (Postfix) with ESMTPS id
 82F6218020E2; Mon,  8 Sep 2025 10:16:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=v3KhJgc1gtSkPiyEIZ8Amfodzc39yWWHTJaq8u9Br60=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=y5sTGkGYT5YJeNFs1K7C3tZ7bkmUQeLUxNQBJmt28qidh59g/xmrqqOOLZUKsdwLb4DDN4WEgp5umuAlP1QHCK28j4s8AM4vJTrxdufsOxl0ysB55+drIoE4KEQTOjmg/UNxaU/MCOkSq4U4xTSg/MhNcZrSNoj6NX4W45JxdUwNIpNHz1LZSpmp7882h3JEFz7A00D0byvmhytW7V36ziPDCufHCzOv5qqY9uM2dQ/nh/sBYeZoU/T1wzEp7lVUmKHAVH4HvR6zOiw0l9Y9ps5+OxA1BA5wza1rVujmy89l2JkOOFUf5ov4wbStKL8VNGlCIWjn/sEK4Hd0fnYmXQ==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-1 (Postfix) with ESMTPSA id
 96ECE1800166; Mon,  8 Sep 2025 10:16:48 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 07/24] accel/hvf: Mention hvf_arch_init_vcpu() must run on
 vCPU thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-8-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:16:47 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15E992C0-C050-45E6-9072-5B875ABEA2F7@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-8-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: LBj0UcwNWPg3bb1FRwpJKTXtpUv2Gt4R
X-Proofpoint-GUID: LBj0UcwNWPg3bb1FRwpJKTXtpUv2Gt4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX34FLDtOpYFTB
 YyQYGp54ACEsYFBHs3N6USv+L3NDP6vmnguD5FH4J+wDc4rxNNiUQpp8zOZzK7IqLwJJWeS+U/H
 aeOh41TBi9OE1M16vFEDt8Vb2h1e0K3DSBSkkPUac4WDwC9q9d3fCEYbgkgRGSXKo4ncf/z9Rws
 PmwKjFuUTyqWTLOdOExMYQBmj9QXFTm39NqMoYb1ZDM/cnLD+M1zv1XIQaQYFlYVoQJXBOv/ggR
 v0wqrfra1xxPNnpyyv4N8rvTurIwJnedE8/TAuCPxrhBiHg89lI18lfSvynyqNO/HmhGTbVW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABeDNg8De4QCJUFAaHQCSHQLhXdMG89RQbzcbKLv5Qj69PUwOihy9ufGN0zdvGT90k6/Vljd+p/O9HASMGtmFEHece9feh/N99i52OH/ZPsunIYd2mzEmVSOWQMWur0dCTboCt7g+Cjlo7JorCqki5vVh1Q77EJA7+RX9qT5ykqGMwJGMonnCe2PXnzEhs9iZhLNXhyLHkuxCwmn5iEktpQcQXxotF924Qu8GvbQtZn7tjAnfpt1Bm1PPy2eh+wy+sP7aLNMda0vHBjOSNsY5TDomKIjRXUs00KxMOLaVV1taV2NhFWmSQfRy6A0CzCBA2MTIszgjKQ/ylQs2Tn5grvrwIveJt0aw0z3Su7olmiPefn6WE5lCHLTr4HgYPXahLRjmF1rMwPpn3CjXv1tRUrblgKk8LfnXMDd1jEHZUzhdw1HvFxjFAupzm7MXkW0udk6EnUP67MLPlQ0i+dx4bq3wconz8eogT6yfuQQ/sAya5lOKkWY83JSLVa74i8ww7ZO39KiFGQepxDD84kNgVqXum2YAbhD3ymYB/7kWeruI3AjrlTjy6/0TF24dzudFHU/JYTyq6ahZNbCgUVcovoSxJ81PlE1bJUHaW+tr+v7XajqIVZxdb2hDj9TwaT8HmzVmplrkBGNsoOQGQQeq/9oFHchQwNBmlUSrw3pkodj9br+r9Srgt3IXw/WwycaKKbmpex4PyPkvTyjLOOMZqYh9E7Kc4zP4=
Received-SPF: pass client-ip=57.103.88.13; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> hvf_arch_init_vcpu(), along with hvf_put_guest_debug_registers()
> and hvf_put_gdbstub_debug_registers(), calls hv_vcpu_set_sys_reg(),
> which must run on a vCPU. Mention they also must.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/hvf_int.h | 3 ++-
> target/arm/hvf/hvf.c     | 2 ++
> 2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 8fce627b08c..0c335facc3b 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -71,11 +71,12 @@ void assert_hvf_ok_impl(hv_return_t ret, const =
char *file, unsigned int line,
> const char *hvf_return_string(hv_return_t ret);
> int hvf_arch_init(void);
> hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
> -int hvf_arch_init_vcpu(CPUState *cpu);
> void hvf_arch_vcpu_destroy(CPUState *cpu);
> hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
> void hvf_kick_vcpu_thread(CPUState *cpu);
>=20
> +/* Must be called by the owning thread */
> +int hvf_arch_init_vcpu(CPUState *cpu);
> /* Must be called by the owning thread */
> int hvf_arch_vcpu_exec(CPUState *);
> /* Must be called by the owning thread */
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 58934953c4a..d87a41bcc53 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2244,6 +2244,7 @@ void hvf_arch_remove_all_hw_breakpoints(void)
> * consists of all hardware breakpoints and watchpoints inserted so far =
while
> * debugging the guest.
> */
> +/* Must be called by the owning thread */

Should this be combined with the comment block above it?

> static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
> {
>    hv_return_t r =3D HV_SUCCESS;
> @@ -2282,6 +2283,7 @@ static void =
hvf_put_gdbstub_debug_registers(CPUState *cpu)
> * Update the vCPU with the guest's view of debug registers. This view =
is kept
> * in the environment at all times.
> */
> +/* Must be called by the owning thread */

Same here.

> static void hvf_put_guest_debug_registers(CPUState *cpu)
> {
>    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> --=20
> 2.51.0
>=20

With or without the change:

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


