Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7C5ECD6F7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 23:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqJrq-0004Y3-EW; Wed, 11 Feb 2026 18:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqJro-0004WC-1a
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:43:32 -0500
Received: from ci-2005i-snip4-7.eps.apple.com ([57.103.89.218]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqJrl-0007u9-RR
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:43:31 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-13 (Postfix) with ESMTPS id
 BEF1F18001CC; Wed, 11 Feb 2026 23:43:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770853407; x=1773445407;
 bh=BxR9SGIQu32JPe9a+wjjA6lNt/g4Cugal/lXSqO3GFs=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Q8ikpP8eDZtdEFb9sBcj6Q+ebDR61hjMCEbLJKW1gj3D2IBsgx7T/aaiQ+FEfmo71FSm209bknjz8BCJsJVfsOUhoWm/SYqDuwhuWiNy7kOhLhqy1OlL2b1PgssAsSe48FQ+Cpr2P8yW+dHqhaemRpVLiw6GFvk6WeonHbfukM5T44kABfnzSvr8jpPdY07k8deyDth1nNWaRc7dmhmHUiV4mRaW4Wqi/25YUOojUWVlXJ0shAM93rNnswqAgfNm1tOLnwXk+rPX7B1HT3nxVDlrvLYfzi8qYHPr++SYOOhnxrJ7dp7jE3Yf0OznsIs8wspU8Z7QgdtYZa5ptpvhOA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-13 (Postfix) with ESMTPSA id
 1688A18001EB; Wed, 11 Feb 2026 23:43:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
Date: Thu, 12 Feb 2026 00:43:11 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <792A279D-EA08-4174-B55D-BD94098541B8@unpredictable.fr>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: ynigfNCy1DrFWv05XxHerq2qgRjMbBqi
X-Authority-Info-Out: v=2.4 cv=Urhu9uwB c=1 sm=1 tr=0 ts=698d141d
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=yMhMjlubAAAA:8 a=sxE6j1IC_1gsK5hKYW0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE4NCBTYWx0ZWRfX3TECu38Hj9h2
 RXFHlnogT5wkaYdZRTVH6NA204+OwGWj+qtVMwDxm/aWepYeZjE0USc913EVYj9khGN/zCvCq4Z
 eeebbaa5+2BEhx54QsX1K6X5IEI9bPkeUUQXicoypYDlshLkOus9j+3Fr5zaUB/HGY1p1qbgSUm
 Hp/4Bve0Ej//U37JNHpTROO5OBdeJhymtQtjEhxUI6sQZ6XF2k0xmmOw3ItI6Jzwgbrb+5xFX0u
 IdzmAOc/t6p4iMAhPFKoAiPc5MTVHHX+NM9tyCXiSfkydXFS4SBi2mjnXvqKbmrVhqTqfJGlTF5
 V34UVTvO7mAdgdAWN6f34V3EXsr+nMQlngKl373g+y/qWL0GwkckBe1YrYn7Cw=
X-Proofpoint-GUID: ynigfNCy1DrFWv05XxHerq2qgRjMbBqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1030 mlxlogscore=441 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602110184
X-JNJ: AAAAAAABL7Fzflav/baDAXSGSoe96wwnw6d+bRNCocUfLlSPVOGKrUnB3xUbZ3QmnUAct7/RaknNNHeynf/H+5bdMeatJjm1Gyiw56uT15lJW91ah+WNW1x4yDfNLjeZyZH92f7a9RmwuoJ5Y0g7skrDM3EHhFx/SWvBcMO4h3o+gbHj4d2nlru+7f+2vyfUeY20QYSpEGmAvKnNrZHddm2ReoJIjSXkBuFag2XB+MKedZofcfNKQkSS6YUmaWs149To8XU21zSP2ZBthao1YZNaRnKEZZgQstwfzXNvRbhtZkH/CvdtKU2HCzZ4nGlqtoRVyuloLHQ9q/tMAqmgHJWsLQbiFIxZFCFRvUg4KNjJotnk9QFnZqxEdyOlvx76F8GIlXn0XcL4ge6EP2hqtbxSI+dLSsh4xq7+Bt39kgRuZiue5Z3Tcv5jE3awsdG0ffbjoyYlRKxAohdPSeBHz8u1baektmLyIw7tjK1GSV+W7keHRXjNdqnE8JBcFgnIVpjzmN7Mcr6uD0mrjhKaUgSL3quybnSOAGT5vEumjhQG6lP7KgqfwrqgSRceLFRD4WKkpx6dcKNpwUo4yUWw8fWRHQqoFMLVTb2FHdrHAPJu2oWkaszvo+o6jqPr5bCIicpbEpiOP/k4OjjfAn5rSO/7ULX8QKIgNHdmjPB564LhgoljYYPEpfn9lP37Tqz387MlY/RFWK8jUGw=
Received-SPF: pass client-ip=57.103.89.218;
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



> On 11. Feb 2026, at 16:54, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> When using the extended request format we can instruct the hypervisor =
to
> provision enough space for requested XSAVE features. This is required
> for supporting QEMU models provided via the -cpu flag properly.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> =E2=80=94
[=E2=80=A6]

Hi,

On the 1st party Microsoft headers side (as in WHP), the two banks are =
defined separately.

For example:=20

ACountMCountSupport instead of a_count_m_count_support

Any reason in particular to diverge and would you prefer to use the =
definition here in WHP too?

Thank you,

> +        /* N.B. Begin bank 1 processor features. */
> +        uint64_t a_count_m_count_support:1;
> +        uint64_t tsc_invariant_support:1;
> +        uint64_t cl_zero_support:1;
> +        uint64_t rdpru_support:1;
> +        uint64_t la57_support:1;
> +        uint64_t mbec_support:1;
> +        uint64_t nested_virt_support:1;
> +        uint64_t psfd_support:1;
> +        uint64_t cet_ss_support:1;
> +        uint64_t cet_ibt_support:1;
> +        uint64_t vmx_exception_inject_support:1;
> +        uint64_t enqcmd_support:1;
> +        uint64_t umwait_tpause_support:1;
> +        uint64_t movdiri_support:1;
> +        uint64_t movdir64b_support:1;
> +        uint64_t cldemote_support:1;
> +        uint64_t serialize_support:1;
> +        uint64_t tsc_deadline_tmr_support:1;
> +        uint64_t tsc_adjust_support:1;
> +        uint64_t fzl_rep_movsb:1;
> +        uint64_t fs_rep_stosb:1;
> +        uint64_t fs_rep_cmpsb:1;
> +        uint64_t tsx_ld_trk_support:1;
> +        uint64_t vmx_ins_outs_exit_info_support:1;
> +        uint64_t hlat_support:1;
> +        uint64_t sbdr_ssdp_no_support:1;
> +        uint64_t fbsdp_no_support:1;
> +        uint64_t psdp_no_support:1;
> +        uint64_t fb_clear_support:1;
> +        uint64_t btc_no_support:1;
> +        uint64_t ibpb_rsb_flush_support:1;
> +        uint64_t stibp_always_on_support:1;
> +        uint64_t perf_global_ctrl_support:1;
> +        uint64_t npt_execute_only_support:1;
> +        uint64_t npt_ad_flags_support:1;
> +        uint64_t npt1_gb_page_support:1;
> +        uint64_t amd_processor_topology_node_id_support:1;
> +        uint64_t local_machine_check_support:1;
> +        uint64_t extended_topology_leaf_fp256_amd_support:1;
> +        uint64_t gds_no_support:1;
> +        uint64_t cmpccxadd_support:1;
> +        uint64_t tsc_aux_virtualization_support:1;
> +        uint64_t rmp_query_support:1;
> +        uint64_t bhi_no_support:1;
> +        uint64_t bhi_dis_support:1;
> +        uint64_t prefetch_i_support:1;
> +        uint64_t sha512_support:1;
> +        uint64_t mitigation_ctrl_support:1;
> +        uint64_t rfds_no_support:1;
> +        uint64_t rfds_clear_support:1;
> +        uint64_t sm3_support:1;
> +        uint64_t sm4_support:1;
> +        uint64_t secure_avic_support:1;
> +        uint64_t guest_intercept_ctrl_support:1;
> +        uint64_t sbpb_supported:1;
> +        uint64_t ibpb_br_type_supported:1;
> +        uint64_t srso_no_supported:1;
> +        uint64_t srso_user_kernel_no_supported:1;
> +        uint64_t vrew_clear_supported:1;
> +        uint64_t tsa_l1_no_supported:1;
> +        uint64_t tsa_sq_no_supported:1;
> +        uint64_t lass_support:1;
> +        uint64_t idle_hlt_intercept_support:1;
> +        uint64_t msr_list_support:1;
> +    };
> +};
> +
> enum hv_translate_gva_result_code {
>     HV_TRANSLATE_GVA_SUCCESS                    =3D 0,
>=20
> --=20
> 2.34.1
>=20
>=20


