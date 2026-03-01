Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4CCFD0076
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 23:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwpkw-000755-Le; Sun, 01 Mar 2026 17:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwpkv-00074U-5c
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:59:21 -0500
Received: from p-east2-cluster5-host1-snip4-9.eps.apple.com ([57.103.79.12]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwpks-0007AI-Tj
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:59:20 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-12 (Postfix) with ESMTPS id
 E542918000B6; Sun,  1 Mar 2026 22:59:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772405954; x=1774997954;
 bh=ou59ICysOs6aVRaoGnQTeMquA1DHiryx/u76HI7CPb0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Qz8BO4qoECbD5UnWa4JkUOGwtVtzblrpnlNymX3heqFGUqV0q3gVm9E3PviQF+b3L9/1gc9dPTujkk9PTKijnIUVJbPtisQ+SH/NIXpJenIcU4hwWYuhkKpL1OG3mUADmV2/z6cXM15TVRKkrcK17zM/DdYhAQNYzfUdp5kL/zRkKu2JfmxOab5JHr4FyTSiS8TTvbYeiaDIRlt43xFHlSN9zddfyv0P3h9yF5Egd77xv2BeHCVagjhtqgrjsWQIR26vquaAMLQId1tcYtUsc9h2IkUTlIHu3wVQg+fjEomOyXfoV2biuGT7ZPHQL8nNF2h4SRla7lX5sUZxQlST1A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-12 (Postfix) with ESMTPSA id
 1091918001E3; Sun,  1 Mar 2026 22:59:09 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v5 2/2] hvf/arm: expose FEAT_SME2 to guest if available
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <8abec38d-8176-406e-9345-b98e69d5bed0@linaro.org>
Date: Sun, 1 Mar 2026 23:58:58 +0100
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEED67A4-C0CF-4952-9F1F-CCF53AEBEF1C@unpredictable.fr>
References: <20260227-sme2-hvf-v5-0-1c60a92910c8@linaro.org>
 <20260227-sme2-hvf-v5-2-1c60a92910c8@linaro.org>
 <8abec38d-8176-406e-9345-b98e69d5bed0@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=MN1tWcZl c=1 sm=1 tr=0 ts=69a4c4c0
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=2hGvlMElPCzoILfs6cIA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDIxMSBTYWx0ZWRfXzg69g7gqk795
 7ZN2cRq33dqFIsc7WOpsORySH/XUXiIMQB+OxgVMYoEF90+4PuEpuycZy35VWW1TZhNYIF8Xglt
 u/LwB/vjYbsD5D3jo3a57SrhK++HNxq/+fA7JDhxod2gfMG5uRcfjrrTcji+DxeLsAbwJQ+56Pe
 FO7AnG2ZGXLz05jnsK/EeoU8iteQ/PQGESY0FTCjEQWtK0Y+xrdk6WwN19zPLxAjO1rhMh3t4YR
 1Uodfs/Syv89qPKAPunOJ2y62YGAIwynnZQgjzDwqj8tdKAE2TV4a7XZJKMfnwa/BMvN5vvrFhp
 KbtOIRHIOQIntujqzZ0hO8Ua4pMO5oLlFvVKHo4Ti6OyGZFh1DQ4qaZpHysjBU=
X-Proofpoint-GUID: r0r5PYDWnhKX01gZTO-26LTts9_yKCvX
X-Proofpoint-ORIG-GUID: r0r5PYDWnhKX01gZTO-26LTts9_yKCvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=844
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603010211
X-JNJ: AAAAAAABxag+tvAPNm8Hf63VnvdBT3ysh5kG5uVSmSBVIWRnQtRFcwIiWkp43+wDqnu8u8azYsFfu/E+/JLtdOTaC86PcOZvfeDTdCPaJWwff5D/I6Eaxe87HbdsByoINVw5rJA4kJ8vz+9Jbm2PDiBoVm8KhAaI1RvKRP++UF/Thubb4V2OT8KrXYdEfBtfj3uimSMK6v75jZd3SvNDc7YhjndI7F8/xiPb3BZWqF5VtnRwx3JD3G1orQr2JPLbYvrNlWhLdry9RTnYtHCoVNjs7qZV7N/dP5lEDyg35Nr+IH9YKffU33Ij3THyRuEJAMccl4JBHa1XabVIeuimYWwV10xM1qrP4frc4flB6OOOhKmJaa3mTrR0MkPRnrLiGDFbB8B4gAY3PbhRgq7PRDBRLaoXgUsDX/DEnxDwJqPQPKtj6+aMoEg9VDUQOO8BvvdM8u5F8eUbGKhncPdUtHSCdKQEQql8BhiJ8ndKL2GvVMvgaPrRI8bhcfEzT9IUUlYUJVJl10TGHTnKFv7E8MJwrJ5yOlOnJvLE2ohrEvMbJWhqXz18gA3bW6llZEYUa/SLqMjfKW1nkkUNwm3aH3sk/xfaMVHKS7sUnqPS8a+0kboEmnOyABZLHa33ecZFQq3VlJaJzSiW30GLKZn1wrG9fC6orwWVARG9BqVTShBqcy1i3gE0NS342JDN3cXg40VPx/NOirUeRxjqfIeH6OdVz9rLjvgXY/P4Ymoj5Cy2YFQ49AdPOWjL2wR2
Received-SPF: pass client-ip=57.103.79.12;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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



> On 1. Mar 2026, at 23:29, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 2/27/26 19:56, Manos Pitsidianakis wrote:
>> @@ -1121,18 +1122,18 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>        clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
>>  -    /*
>> -     * Disable SME, which is not properly handled by QEMU hvf yet.
>> -     * To allow this through we would need to:
>> -     * - make sure that the SME state is correctly handled in the
>> -     *   get_registers/put_registers functions
>> -     * - get the SME-specific CPU properties to work with =
accelerators
>> -     *   other than TCG
>> -     * - fix any assumptions we made that SME implies SVE (since
>> -     *   on the M4 there is SME but not SVE)
>> -     */
>> -    SET_IDREG(&host_isar, ID_AA64PFR1,
>> -              GET_IDREG(&host_isar, ID_AA64PFR1) & =
~R_ID_AA64PFR1_SME_MASK);
>> +    if (hvf_arm_sme2_supported()) {
>> +        t =3D GET_IDREG(&host_isar, ID_AA64PFR1);
>> +        t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 =
*/
>> +        SET_IDREG(&host_isar, ID_AA64PFR1, t);
>> +
>> +        t =3D GET_IDREG(&host_isar, ID_AA64SMFR0);
>> +        t =3D FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 1);   /* FEAT_SME2 =
*/
>> +        SET_IDREG(&host_isar, ID_AA64SMFR0, t);
>=20
> Why would you need to do this?  Surely these values are already =
correct.  And if they're not, did we miss enabling something earlier?
>=20
> This will break the moment FEAT_SME2p1 is supported.
>=20


FEAT_SME2p1 is already shipped on the Apple M5
> r~


