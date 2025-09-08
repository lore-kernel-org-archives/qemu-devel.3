Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BC4CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYw1-0007Dz-Mt; Mon, 08 Sep 2025 06:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvr-00078B-B4
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:07 -0400
Received: from p-east1-cluster7-host1-snip4-10.eps.apple.com ([57.103.88.13]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYva-0001Sb-UL
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:06 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 779B71800579; Mon,  8 Sep 2025 10:16:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=QO1umtmjrWseiPN6/pJIIqxWPn2ESQMp+7TmdGbHeLM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=woOsKWDNdaTlUkhVvqxR9M37JJ/3jVaiVEs39nULH3HxQB5M1DgbFkuYaMsp3V5X6yuFxANqYr57+XgoJ2BycYXUNwSKxlB94qOjVhrhwMOnXT8tPAgRUHoPQiz7jfue3IbI6/XC8yadmiZ/wowMaieRVMWTbQMGQVRyKQHq9823SGXs5aMa6//6ZTDQQxzNbc+0mk8o3ld4dWnsYU1YJFCGfrGaLLcBowKbeqX+1r2VMY9OpJHUCCaHBtAxu63gZKXFuU3neoaLixNFzni5MrbLWq5XcQcenHGfypNnHlw7PBHsHBE99qQPlx9Mt/hJKyR1QVby1jVc+sms9NM1IQ==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 67C591801C9F; Mon,  8 Sep 2025 10:16:39 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 08/24] target/arm/hvf: Mention hvf_wfi() must run on vCPU
 thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <c51382aa-070f-4441-a707-a29d87093b48@linaro.org>
Date: Mon, 8 Sep 2025 12:16:37 +0200
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E865FC0C-D02E-4BD4-81AF-ADDA4827DFBD@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-9-philmd@linaro.org>
 <c51382aa-070f-4441-a707-a29d87093b48@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX6uZHimnOYdNd
 TXyQGAutycBbb5HtF5inI9xu5fq67Xw2qKQVjjQhyyMfyZ/LazouixhttCkfUvJmBkJFh96VzxT
 7WaIawqbfDQchuI1CX8n2LLGdTqaCr4OsIoLnTP+Z9LXXnyIBWos/ryZf5+u5lcmgmH3005AA4q
 N5Zip7lmalsG/7MFfEJRf/wmmK+wxDDZoWxzIEsfIa/A7cV9dVjii90YHv9echKZezX5msHwv5u
 wI7FwCAEZZxbMJfe2G4E2E1zYmUSVmduQPSuZwJsBZmXzKgWV7Qvh8EHHjmRWsEwsfG0dMpUE=
X-Proofpoint-GUID: tuh4xTDf4Mwnkx4FMrbyFlk2rKmIf0Gv
X-Proofpoint-ORIG-GUID: tuh4xTDf4Mwnkx4FMrbyFlk2rKmIf0Gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAAB7iz10QwmU0nZHM7XHijHjrL5cbbCpuCpgaYnC/PnPKCTABfCZDMjJG7FL0lEkzvomwfd6aB2RS+3IuOIJqu0IbZ7PucqeetMjbbiZdGsYXsQ7gTR8tLlEVckhzlgyckd3VKM+wmj4o5U/BgOJ2pes4CR8FbTlTSeWjEhTwa/enzZDpxIYq3TnrB0l26tsmxS5ooy1LaIAV96bJv/ErjzoYwivCRXbIfIL0QCu+WrcbD1824yu00a5QlNQ+pirGqZpzz3199WKlCcawsxmDi7w8Vj2cLWlacoEQu81/Z/vwA4N2un57yvaeNAn7a3Z4UqidR5Qz4pwrW3s+DqWTPAyexRwyf+56JqCQo4jOUtAD132qhxMYfce76Jrdqu++JCIwhiHEYCJ7c6mCjuQWpEkAbIXtjSBVoRdKm/9nUeSxpZnjkmYkOLUyWehx0h2Dz5iIkyaZ0QZyPaBHITWKCGOKgenJfJl/WH3zTHjuVnAVMNCnuZOTi187jze+u9yT2CeV79fnvC0N4AGuXUfyqmN/81ma8QRPfSTjYpbUMRj2qq5h8c/jh8imDdF4bprsIjimIV6pwOw67j5+YalfWf/zfGZo9Lj3ftmfmkUnR/YOZV2itsGtcPaoJqbXLK2bEE9ZiVy2Moj4pQwye/s2wdi5mxAYZr5os7s4gK90kjimVFbxTFs/F2pXVx/VftkqXkhXlpNqrFXzx5DJX5jh/3kDZHx9U=
Received-SPF: pass client-ip=57.103.88.13; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 3 Sep 2025, at 14.34, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 9/3/25 12:06, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since hvf_wfi() calls hv_vcpu_get_sys_reg(), which
>> must run on a vCPU, it also must. Mention it.
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  target/arm/hvf/hvf.c | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index d87a41bcc53..05fc591b523 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1836,6 +1836,7 @@ static void hvf_wait_for_ipi(CPUState *cpu, =
struct timespec *ts)
>>      bql_lock();
>>  }
>>  +/* Must be called by the owning thread */
>>  static void hvf_wfi(CPUState *cpu)
>>  {
>>      ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>=20
> How can it not?  Are all these separate patches and annotations =
helpful?
>=20
> r~

It's just part of Apple's API. It's documented here:
=
https://developer.apple.com/documentation/hypervisor/hv_vcpu_get_sys_reg(_=
:_:_:)?language=3Dobjc

If they are not called in the right CPU context, they'll return an
error. I find it helpful to have it annotated here.=

