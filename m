Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D3BFED2FF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dYW-0007CN-ER; Thu, 12 Mar 2026 06:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0dYT-00079T-6R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:46:13 -0400
Received: from p-west3-cluster1-host12-snip4-10.eps.apple.com ([57.103.73.251]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0dYQ-0007uS-UB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:46:12 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPS id
 A0FA218001EA; Thu, 12 Mar 2026 10:46:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773312366; x=1775904366;
 bh=vcFnGmQQ32XRb2U8FiZn0syqGe1g2Kuz8WvX+pQ86gM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=glvWNypg0woT+UWd3FlW4zDspLj0Ml6ZjrfRgGsmWf27/iIFtX6NA1xhl8c+czRDop2ErnJNS4MB0KoAY0NxQUPuzxcO/7/au7WBJTsLfzpRJnlJ+zRWM9H2q1kGXvJKt7h+xcuPnTDIKUbioA0Pks/2C5k4sF6+z/d30Imr2GMcM21XHjcaTql9EHs0e7IWk599VXcXqAnIV+R7gtiCAeuIV2iTLjncdi3nCmMZhTFXXGVh1688Yk21KV6UpIdL0TQSz/EG5ORc8IsIuba/Qo/SXwimozwIB9FNUUucZPEdvbeduYdYv1K3RnWkb1KiXTSLCKRGvbZnqnbzCSYpAw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPSA id
 8257918001C1; Thu, 12 Mar 2026 10:46:00 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260312-lucky-cocky-whippet-2a5f3d@anirudhrb>
Date: Thu, 12 Mar 2026 11:45:48 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA5B0DE1-CA87-43F6-9A52-2F9F91F3514D@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
 <199EF957-0EBD-4E14-8453-1C5FA5B14063@unpredictable.fr>
 <20260312-lucky-cocky-whippet-2a5f3d@anirudhrb>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=Xqn3+FF9 c=1 sm=1 tr=0 ts=69b2996d
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=tFGNSmrwAAAA:8 a=yMhMjlubAAAA:8
 a=UMoMHAngHAYsTGonUBsA:9 a=QEXdDO2ut3YA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-GUID: N5Ihymbqfo03xIagtwYcr34DhtEEzyTV
X-Proofpoint-ORIG-GUID: N5Ihymbqfo03xIagtwYcr34DhtEEzyTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA4NCBTYWx0ZWRfX2wcDxtCEc5mC
 +iqTwVkVt6htMYT1C3Ab1dvbvuhk3HKs1fCLLgjgTa8iFfiXetBfVSqCb7jx3rKMBVlBYPBfr6K
 90zxG4Z9QTU9cRiMsluSfw9idLuRuw7D58eg771/WuhMheGiaVOyR8Q1opMv9KlHQ/4ciFWc7na
 PR1Yepok4BUtcmthftWYFNjoVzoLIgIwAmYt6m6JI5I1HHJ8nztddA/OAD3RBq8oM3z5ngFetut
 n9Sz+ZtltvFNpuLGZeZqiWFJgrjcboBrFW2P8FkKKwz73tQbLzS1F1xh6mkLdfidQ0FFbyJiNhS
 EIk8rkoseqdRzBN/Tu3mg440BRmZPSdXwSlS6Z11ENxnXwXTBxzDctSvMDVVmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=511 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1030 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603120084
X-JNJ: AAAAAAABZ3GGz0oBvECnT551WljJg2NXtyfXJ9ilp2Sph1DUqEQtGSAji6LY3r0emompb60ezmBATjgV3j9bFoT86c8k/RHTLzoZr7fT5zJxJLZADzVPlbHUfF6swl3PQhaECPs108GK6gEL6xF+Z13bftPQIJPXieajqBo0rJaEv9YoWGo4VMRtKo6TqNVrL1mECEwura9juf5yycfeDEf6D7kjKZsvNCr3dDXBoLJajhYlbJ9o5MonTUBL+rCjgwSEdS4YApWE8j0C4E8XvUYV4RYmS/6st93Jqw+H0xqurmY3j6hLDv/sYBPg2d8STEra4xvbr9+kkEH+FBnrXVH7wMbz4oWeIBbpdf7M6FCJJ7NvX0ZSXTQ9fijOSqsykEPuUsXL4une2E4v0o3elgBxMIRlHybJd6UJNec5eLb31ax1Lvo0iMuWsOHaRbQH8b5hiJduMosAB7+uLe+WF4HIjwSGsKx2NnVmN7cO0XHL5+3VGmxuPEbjogcF3ybb1/928TanqWe2uRurjl8KZU+EBkoVMyfkprMBuhaoKcpeEMPJ+vUGvboYzzvpwc768PUUvmdH7uV8hjedoOOtK5XU9bNWtnOfdFRm8a2Bw6ZV0VsYPO8vz0vFQrYvVGRbbA3/5309Vvmi++53CGBDQvgJMzDgi51LVc1DpD/9RUI0ClsrnqJCIoC6JbY+c6ZN2C4Pj5aEDL2WiMLAgT8Fpr5ojBay1DUnVs2JTgj/TyvwRYYD3RN3O2oBVDDySlTwjJJGH0187gdi47t4llasutkLOuqKlxFAUyMnLODpWriAOg==
Received-SPF: pass client-ip=57.103.73.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



> On 12. Mar 2026, at 11:32, Anirudh Rayabharam <anirudh@anirudhrb.com> =
wrote:
>=20
> On Wed, Mar 11, 2026 at 04:35:31PM +0100, Mohamed Mediouni wrote:
>>=20
>>=20
>>> On 11. Mar 2026, at 16:15, Anirudh Rayabharam =
<anirudh@anirudhrb.com> wrote:
>>>=20
>>> From: Aastha Rawat <aastharawat@linux.microsoft.com>
>>>=20
>>> Enable access_vp_regs feature for regs. In arm64, this feature bit
>>> allows the guest to set VP registers using hypercall. This wasn't
>>> required for x86 because such registers are set using wrmsr instead =
of
>>> hypercall.
>>>=20
>> Hello,
>>=20
>> Could you split this into two patches? With the hvhdk.h changes in =
another patch.
>=20
> Any reason why?
>=20
> Throughout this series we're introducing hv*dk changes along with the
> code using them. Isn't that a good idea?
>=20
Hello,

I think that because of some of the content of header updates aren=E2=80=99=
t immediately related to the commits at hand, it=E2=80=99d be better to
just have a single big commit at the beginning of the series for any =
GDK/HDK updates.

Oh also, preemptively adding some header definitions before they=E2=80=99r=
e immediately needed could be simpler for everyone
- especially given that WHP exists and is overlapping a lot.

Also makes me think of whether it could be better to share some code =
between WHPX and MSHV, but that=E2=80=99s a separate
story=E2=80=A6

Thanks,
-Mohamed


