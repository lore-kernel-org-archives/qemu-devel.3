Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5293C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3Wt-000814-C1; Mon, 17 Aug 2026 16:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ww3Wr-00080p-FW; Mon, 17 Aug 2026 16:01:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ww3Wp-0007tM-QY; Mon, 17 Aug 2026 16:01:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVf8Q2076135; Mon, 17 Aug 2026 20:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Lw2866
 bq+l7/cmA78RFmFLf+HEPoLK2Wy7tl9sDc0cc=; b=BBbbzPcug3J4zB0vtibxf0
 msXEQuCsC5ywadAKgIRK3d4lXUjhneQ5UwyKmbp4uE8ecOpn8r1zjDK6oFPOD+Wl
 jDjNM5b6dkkYWmWIDhb25ZueEzS7WvM2mVHYREznsWEfOBFj9Wf2nG9bdh65WaJW
 II6FUb1chAOqXottZzdfbNzXsh01Yz9k8HH9my0W/0PyV9YsVa9uNLIJA2YT94fD
 /yWLgEtFUlwMep5hgZvN/acEKbkQPgcxDG0J2vSd9uS1KdDCDnExpR05o6J/kXAi
 u/29FasYTmNmmW+oaL91KJmQ7rqzIuJMDHxibJiNdAlOhvfYnnyli5Z9Cc0A1DQw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkv1fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 20:01:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJuLJB028801;
 Mon, 17 Aug 2026 20:01:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epyp9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 20:01:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HK1ibw26739448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 20:01:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FC355806A;
 Mon, 17 Aug 2026 20:01:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47C8B5805F;
 Mon, 17 Aug 2026 20:01:43 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 17 Aug 2026 20:01:43 +0000 (GMT)
Message-ID: <e9069735-69a9-48dd-8102-72426c1f7589@linux.ibm.com>
Date: Mon, 17 Aug 2026 16:01:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] tests/functional/s390x/test_secure_ipl: Skip test
 if SIPL not supported by hypervisor
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, zycai@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-3-jdaley@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260812152112.3330493-3-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0OSBTYWx0ZWRfX8JrpTr92WWuh
 D9wMr+X04QlDm42cDVeI7wThtWpiZzHEnKi2VRa9H3OP0C2yWfHtlrX1T3zLL/ddw2h+UfEYHsE
 IVo4urrUa56OePcmCA7lTdBWL5VXhGjeY7yIwOwwR67QrmsQ725UD56wWVp4QoTPKnecUsScotX
 FOd4e5paQEHwwJdOBS2Jc2UUIILHIp1RzVSRqqpGr9YAN26gU2cuBiUKDoq//Me5c+dzPsVOSBe
 C17rNJmBtS36qT3cQY3hfHL0XR5gb1VrNewQyFzDNtN+QLOlaFl+mmsGZBMUxip6DpQ3EbLTA8Q
 FWH+hg/xknrJP1icxymaWmgUEDgjGLVfPwVkHfhe7x9PtfQ+Auh8KM+16b03gSBcBVJKdWtsmiQ
 tvLndzIM6DzYvQgz5CHJ5FLQDkSl6eo2MKX9rim9hoTPVFyAExDH0+tRbQSsW/6QSvKpURCmGn4
 9cOrkn78BfHvNN6R6lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0OSBTYWx0ZWRfX/c2z/stdevER
 RmyjBNMFLpmXYgZO6egYpNqvpjO3eKS4t5S7Su8h61KBTKBKbli0O6Fjmql87m3UPzfGlRRqwMW
 qy8zpP0/rpCkXYrtv/8X303RJJvnOJs=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a8368aa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KwKIQBDO4BPv--znDUcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EQxV9ygYkT0FK3qwYeaO6C2ho_WT4FVU
X-Proofpoint-GUID: EQxV9ygYkT0FK3qwYeaO6C2ho_WT4FVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/12/26 11:21 AM, Joshua Daley wrote:
> Currently, if secure IPL is not supported by the hypervisor, the test
> will fail because "Verified component" never appears. One must inspect
> the console log to observe the cause of the failure.
>
> Add a check that skips the test if the host CPU model is missing the
> secure IPL facilities.
>
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> ---
>   tests/functional/s390x/test_secure_ipl.py | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
> index 06fc93e404..5af36b91d8 100755
> --- a/tests/functional/s390x/test_secure_ipl.py
> +++ b/tests/functional/s390x/test_secure_ipl.py
> @@ -29,6 +29,22 @@ def __init__(self, *args, **kwargs):
>           self.cert_path = None
>           self.prompt = None
>   
> +    def _require_host_secure_ipl_support(self, vm):
> +        """
> +        Skip the test if the host CPU model does not expose the Secure IPL
> +        facilities (sipl, sclaf, cstore).
> +        """
> +        props = vm.cmd('query-cpu-model-expansion',
> +                       model={'name': 'host'},
> +                       type='full')['model']['props']
> +        missing = [f for f in ('sipl', 'sclaf', 'cstore')
> +                   if not props.get(f)]
> +        if missing:
> +            self.skipTest(
> +                f"Host CPU does not support Secure IPL: "
> +                f"missing feature(s): {', '.join(missing)}. "
> +                f"Secure IPL requires a z16+ host.")
> +
>       def _create_certificate(self, vm):
>           """Generate x509 certificate"""
>           exec_command_and_wait_for_pattern(self,
> @@ -107,6 +123,8 @@ def setup_s390x_secure_ipl(self):
>                            '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
>           temp_vm.launch()
>   
> +        self._require_host_secure_ipl_support(temp_vm)
> +
>           # Initial root account setup (Fedora first boot screen)
>           self.root_password = 'fedora40password'
>           wait_for_console_pattern(self, 'Please make a selection from the above',
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

