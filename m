Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB62CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYvk-000718-0r; Mon, 08 Sep 2025 06:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvi-0006zO-MZ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:16:58 -0400
Received: from p-east1-cluster7-host6-snip4-4.eps.apple.com ([57.103.88.57]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYva-0001T1-R0
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:16:58 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPS id
 19B0818023D5; Mon,  8 Sep 2025 10:16:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=fscr5kkqBf5eU7YByrSLBpkh3oCOoUOloTqQmwiW0NU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=O+OW57intQlxESZnsnp7+027cDe1QxeLO+ltYCfyDDTMqfMqSqP56blH1ZuM3dFS88QoBMLhcPCP+i/trwJhrWkpKmCUcTmDppcQJ6bD3bT58paPmKKDCuAgK8pZir5w3RLWKpxNJqSMBGK2U9fSV1wuhtDG6UFjalKhKuHsenwQzQuMaeTBVXlOo2BlFDBdD/ua3CPm2zFpTLK093PyzAGvZO7ovdTMJ/rNw5IDr0PyYDSmu3RgstftO6MXA/EzJnQaoXjYrMimhZsKYvZTFH6ScIcVikqSnryZYGug8otu7PoJ1LFij+k2EsA6hFqN/Dj5Ydx4Bd6S8OVNMf8bCA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPSA id
 388DC1800A68; Mon,  8 Sep 2025 10:16:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 08/24] target/arm/hvf: Mention hvf_wfi() must run on vCPU
 thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-9-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:16:42 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <957A4C79-DD15-4F8B-869A-3F06A994ABFF@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-9-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: VnrCTo0f3PDNprfHSiROdo_ovf1KXN75
X-Proofpoint-GUID: VnrCTo0f3PDNprfHSiROdo_ovf1KXN75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX9qf7hBxbl732
 kfCls+LIM86KCbgK13cCS4O3Vl5qVFW1YeCxOZ8XX8NsClbH32bz1dFG+3YM3xo91ueopkkYm0N
 My7LWEarfy6GHyUS4XxZI3KmXNtaIKze/ttdC24BFasyDrIqCi/GjEtwaEsUSET6XhcbQZ/RdDr
 wpUEGZNsU0SMWdj4fVtThu3Z14wrLKQlTlFqifsk7ukNy2/b2Me7GuzDwrCrD2IqohrxLzYxJO8
 hNwp0Lcrbot45PFF0lBCWi9oTAbgP3KnnWonfGSk64LrlCVnXBJH6inZK+v8CkhSQjH8+/y1k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABYOzyAzreftHEpp2N2EZhaSGOlPo1MDZQj98C1G1mu3Kh/k1dvQ614vtE02La/VMa6JIwGVhvAvphnflBfxoJ1TipZWQZPGE/4BI2eHDXQYiI5ALgFwrxMZAfS/xfY56+l3N1rb/S5dEnHRAENud4VxW9oxB3aGBtvHBKC3EWVFCe8o4tWvKlkuUD91RIHl/5XyXt8Dzk5Ou3FGgvsep2DSIog0q3Ad554mt00HZKtT+8fpAGa74ANoybPN199NGIf71OHKkpQ/EbJdS6expIb3+4EjCTDeHYJdEsAwlPn6TxCw9sAm8/5f6tBK4srauF5uzAJa147DaQ9jjIQn8O84gtGryJC9HI6kXO7RK+tUmCfupm5uB3pmQdZKR3xmzR0Y5HldNwYdrxxYbk/BCpqnc5Y6zGdv+6KhVF57hKQMHVyv2WFn6GVbwKaQ6W5aMRX106RECwHKb7HeIykXRrwWn+wNKw/sV1lN4XV1SLOZmLagtgVxl7Zp7OLVaFhEYaJvvsaNzth6Q4W+LjoittzAwQqNxaTfdubfyjPgL0qKt6zcNU/7jQ0VbkjkOKRsdAMRCpkfPQJjNGlocXSSSPaM43ClFinWdDBs69/9NLR5iyesPnHhcMTQKW/VKBuA6ODrjYnKxxJuLPiyNZ9F+jS2hTHxLSKziK/fRvesMlrrMsD6twVSpvUDinV5aMNs0dZrAz7gbI1MKTG9YDktFQ7cdYfSk=
Received-SPF: pass client-ip=57.103.88.57; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Since hvf_wfi() calls hv_vcpu_get_sys_reg(), which
> must run on a vCPU, it also must. Mention it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d87a41bcc53..05fc591b523 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1836,6 +1836,7 @@ static void hvf_wait_for_ipi(CPUState *cpu, =
struct timespec *ts)
>     bql_lock();
> }
>=20
> +/* Must be called by the owning thread */
> static void hvf_wfi(CPUState *cpu)
> {
>     ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> --=20
> 2.51.0

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

