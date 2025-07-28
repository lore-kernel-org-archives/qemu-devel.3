Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA1C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNr6-0000Tx-KW; Mon, 28 Jul 2025 09:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugMxB-0003fC-Vs
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:27:53 -0400
Received: from p-east3-cluster3-host5-snip4-10.eps.apple.com ([57.103.86.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugMx9-0002Ky-N8
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:27:41 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 16C4218000BD; Mon, 28 Jul 2025 12:27:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=LkgYkOREM5xWOyPU0SRd7KbQmBs3iLQIUA4L+z7glg4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FVurEqBbLYnVQ3PjgSyVKRHwaDzCnaedZjDDYyMI5zGNYcaf5x2aLEtNRbUDZrW1nyXtM4D9lmjC0+iDogK+h38ET0dwDKbsBp/nwpN/23Tzk7Uj9cbA59P6cAtVVLUDjOiRyePlznKYP/rbEL2Cmnci5+RiYkPJmEngUlBYnQ5MxXRXVBMUqs1J1QZrqKdJ8r3M0+kR9iu1os/ylYzK+RMlDzkYKcGQTtlorI7nCtyn2OVTgKnCr1JQumuX9Nt78jKRhDy4Dak2DguBcq4OVZRIXFcQz2jkr2WrEDOnLkTOBNPY/SxlAEQDIdOs9uPQZVrHnoT+jwsSgL4cwsL2gA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 DFA4B180016F; Mon, 28 Jul 2025 12:27:32 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v3 8/9] target/arm: hvf: use LOG_UNIMP for
 CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <aa27f93f-5591-4a6d-879a-991004ee5db5@linaro.org>
Date: Mon, 28 Jul 2025 14:27:21 +0200
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EAA23CB-4B4F-4D96-8752-C050F28554AC@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
 <20250725223035.52284-9-mohamed@unpredictable.fr>
 <aa27f93f-5591-4a6d-879a-991004ee5db5@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: FMYYj9W-TGp6WlBGgQGaHDZOEEXJQcxb
X-Proofpoint-ORIG-GUID: FMYYj9W-TGp6WlBGgQGaHDZOEEXJQcxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MiBTYWx0ZWRfXwEXRLOZQLK1I
 lDBAyhY7iWBum+UMEi/sCVKjZ8TjyHlLgHEFdFGYpp1nS6dbyHLAP+Hqfed5yfy1voqfHFsIjd/
 D5a7lzc45GHXR+3zZ7hdsvymUQz9TwiRZJUfREU4baGj0L1XL5PuPGMjDzJ4G464/rEzV+EkPsO
 v2/bbnZbwPXTCjiw6WlGVUGn3APM6jceknQeMwwT95zTFFDzVmQqNl+OD3qxEAem77AZHrYSIDR
 3SJsEsFYCt4kLHERx4WmrOtQ+p/l3F7sd0ij426VE2jeAE4U1qtZ5NNsB1VCKqkwN2eeDyS0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507280092
Received-SPF: pass client-ip=57.103.86.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> On 28. Jul 2025, at 12:35, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 26/7/25 00:30, Mohamed Mediouni wrote:
>> Instead of considering reads there to be fatal, mark it as =
unimplemented.
>> This is to allow experimentation on using configurations other than =
the Apple vGIC.
>=20
> FYI =
https://lore.kernel.org/qemu-devel/20250623121845.7214-11-philmd@linaro.or=
g/.

By the way, am running with a similar patch to that and this is what I =
get - probably screwed up something trivial though=E2=80=A6

[   60.090520] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   60.090950] rcu: 0-....: (0 ticks this GP) idle=3Dce00/0/0x0 =
softirq=3D1/1 fqs=3D0 (false positive?)
[   60.091518] rcu: (detected by 2, t=3D60003 jiffies, g=3D-1199, =
q=3D16542 ncpus=3D4)
[   60.092016] Sending NMI from CPU 2 to CPUs 0:
[   60.092286] NMI backtrace for cpu 0
[   60.092531] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted =
6.11.0-13-generic #14-Ubuntu
[   60.093056] Hardware name: linux,dummy-virt (DT)
[   60.093476] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS =
BTYPE=3D--)
[   60.093977] pc : cpuidle_idle_call+0xb4/0x208
[   60.094226] lr : cpuidle_idle_call+0x19c/0x208
[   60.094526] sp : ffffa9fa513e3d80
[   60.094782] x29: ffffa9fa513e3d90 x28: 0000000000000000 x27: =
0000000000000000
[   60.095263] x26: 0000000000000000 x25: 0000000000000003 x24: =
0000000000000000
[   60.095926] x23: 00000000000000c0 x22: ffffa9fa513edde8 x21: =
ffffa9fa513f97c0
[   60.096412] x20: 0000000000000000 x19: 0000000000000000 x18: =
ffffa9fa513fba68
[   60.096982] x17: 0000000000000000 x16: 0000000000000000 x15: =
0000000000000000
[   60.097511] x14: 0000000000000000 x13: 0000000000000000 x12: =
0000000000000000
[   60.097996] x11: 0000000000000000 x10: 96d8ff766a2f06fb x9 : =
ffffa9fa4e20bb64
[   60.098518] x8 : ffffa9fa513fb9e8 x7 : 0000000000000000 x6 : =
0000000000000000
[   60.099103] x5 : 0000000000000000 x4 : 0000000000000000 x3 : =
0000000000000000
[   60.099541] x2 : 0000000000000000 x1 : 0000000000000000 x0 : =
0000000000000000
[   60.100065] Call trace:
[   60.100288]  cpuidle_idle_call+0xb4/0x208
[   60.100539]  do_idle+0xac/0x120
[   60.100817]  cpu_startup_entry+0x40/0x58
[   60.101123]  rest_init+0x118/0x120
[   60.101349]  start_kernel+0x49c/0x4a8
[   60.101670]  __primary_switched+0x88/0x98
[   60.102343] rcu: rcu_preempt kthread timer wakeup didn't happen for =
60007 jiffies! g-1199 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
[   60.103135] rcu: Possible timer handling issue on cpu=3D0 =
timer-softirq=3D0
[   60.103605] rcu: rcu_preempt kthread starved for 60010 jiffies! =
g-1199 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[   60.104371] rcu: Unless rcu_preempt kthread gets sufficient CPU time, =
OOM is now expected behavior.
[   60.104974] rcu: RCU grace-period kthread stack dump:
[   60.105279] task:rcu_preempt     state:I stack:0     pid:17    =
tgid:17    ppid:2      flags:0x00000008
[   60.105921] Call trace:
[   60.106125]  __switch_to+0xbc/0x108
[   60.106391]  __schedule+0x298/0x770
[   60.106630]  schedule+0x40/0x128
[   60.106836]  schedule_timeout+0xa0/0x1c8
[   60.107084]  rcu_gp_fqs_loop+0x124/0x540
[   60.107314]  rcu_gp_kthread+0x158/0x198
[   60.107536]  kthread+0xf4/0x108
[   60.107727]  ret_from_fork+0x10/0x20

>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/arm/hvf/hvf.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index f5b82cdce1..c3df7e07e8 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -299,6 +299,7 @@ void hvf_arm_init_debug(void)
>>  /* EL2 registers */
>>  #define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
>>  #define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
>> +#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
>>    #define WFX_IS_WFE (1 << 0)
>>  @@ -1398,6 +1399,12 @@ static int hvf_sysreg_read(CPUState *cpu, =
uint32_t reg, uint64_t *val)
>>      case SYSREG_CNTHCTL_EL2:
>>          assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTHCTL_EL2, val));
>>          return 0;
>> +    case SYSREG_CNTP_CTL_EL0:
>> +        qemu_log_mask(LOG_UNIMP, "Unsupported read from =
CNTP_CTL_EL0\n");
>> +        return 0;
>> +    case SYSREG_CNTP_CVAL_EL0:
>> +        qemu_log_mask(LOG_UNIMP, "Unsupported read from =
CNTP_CVAL_EL0\n");
>> +        return 0;
>>      case SYSREG_MDCCINT_EL1:
>>          assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_MDCCINT_EL1, val));
>>          return 0;
>> @@ -1718,6 +1725,9 @@ static int hvf_sysreg_write(CPUState *cpu, =
uint32_t reg, uint64_t val)
>>           */
>>          qemu_log_mask(LOG_UNIMP, "Unsupported write to =
CNTP_CTL_EL0\n");
>>          return 0;
>> +    case SYSREG_CNTP_CVAL_EL0:
>> +        qemu_log_mask(LOG_UNIMP, "Unsupported write to =
CNTP_CVAL_EL0\n");
>> +        return 0;
>>      case SYSREG_OSDLR_EL1:
>>          /* Dummy register */
>>          return 0;
>=20
>=20


