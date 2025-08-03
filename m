Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DBBC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN41-0003km-9B; Sat, 02 Aug 2025 20:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiN1I-0001Cw-1W
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:56:14 -0400
Received: from p-east3-cluster7-host8-snip4-3.eps.apple.com ([57.103.84.204]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiN1E-0007bN-3F
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:56:11 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 9F5D7180013F; Sun,  3 Aug 2025 00:56:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=G0t9gYyWCgQiWdDjgmyaAFFLus+G4LNewl6gKLJ0KNE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=LhUA1CKvzu34MOw4sUJtTQdw1tueWYCh+Hw/fghPT8WJfrazq8X6rMkLwmlqYOJgrCdhKbl6MB2pg1bwHAVyN97PBqUn9aX2WEwwKYt9J45X3jKY351KBEVSNiljAhv8MPPYaQeUt/8+WPXxQ6OB+Sdv/Wbf6ILfQamuUuVufw2QEOdyOWl9+VX7AzTeS0HO4CHyccIC9Tt3v60iEFTbewTC4y+YSBJYArE1Ea4bDbg4ApRlrQ5xdC8mkkmp0r9xsJgptDKRdBU8Dya5Ll3RXKpiUCot1pUUJd59devNwXEiPpzzPQ7IbaW5ZZloyGdsle3pkVNUvgfogFaO2q9z0w==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 88B1E1800127; Sun,  3 Aug 2025 00:56:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <712da351-3bf6-4a31-92e6-b198d5dc21ff@linaro.org>
Date: Sun, 3 Aug 2025 02:55:49 +0200
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <533A5BF2-9CD5-4FE1-99A7-6E9FB212CCBC@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-5-mohamed@unpredictable.fr>
 <712da351-3bf6-4a31-92e6-b198d5dc21ff@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: nO62iqidNK5sfI_jDrZbMHgKVnnxFnoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDAwNCBTYWx0ZWRfX0eWoFF5HGKG0
 xQ+LOoKXtkgchIrnnTTfD/qjqeorJgnwheZTVy3wX2CEKTNr4e8waZixZ5SnLV3Zn82Mkipn8QK
 XyHF6/jbHc852C9r0lPzbB+wMkF7eM2qM2G38lQRSbeBp3hV78y52If2JLIEvbGYCPgzQXELtM9
 YWcVn0WhcgZI7+TKOVDKIuyBpqGO6WQ7tJRz6TQWHXmS9NYIWu++uxZqYKMOR7YZDRBOtDe7hk6
 IbDJw2aSpymYcof/c/wF2ceXhWFNZ6aCkr1EdtJj6hqIDwJt/1kIHdu9vyUIPqy51SRux0ACI=
X-Proofpoint-ORIG-GUID: nO62iqidNK5sfI_jDrZbMHgKVnnxFnoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-02_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 bulkscore=0 spamscore=0
 mlxlogscore=764 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508030004
Received-SPF: pass client-ip=57.103.84.204;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 3. Aug 2025, at 02:41, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 8/2/25 18:17, Mohamed Mediouni wrote:
>> winhvemulation is x86_64 only.
>> Exception exit bitmaps are also x86_64 only
>> Others are just variable definitions not used on arm64.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/whpx/whpx-common.c       | 20 ++++++++++++++++++--
>>  include/system/whpx-all.h      |  2 ++
>>  include/system/whpx-common.h   |  2 ++
>>  include/system/whpx-internal.h |  7 ++++++-
>>  4 files changed, 28 insertions(+), 3 deletions(-)
>> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
>> index b5e5fda696..eeefaea329 100644
>> --- a/accel/whpx/whpx-common.c
>> +++ b/accel/whpx/whpx-common.c
>> @@ -41,7 +41,9 @@
>>  bool whpx_allowed;
>>  static bool whp_dispatch_initialized;
>>  static HMODULE hWinHvPlatform;
>> +#ifdef __x86_64__
>>  static HMODULE hWinHvEmulation;
>> +#endif
>>    struct whpx_state whpx_global;
>>  struct WHPDispatch whp_dispatch;
>> @@ -106,11 +108,16 @@ int whpx_first_vcpu_starting(CPUState *cpu)
>>               * whpx_translate_cpu_breakpoints(). WHPX breakpoints =
must
>>               * now be recomputed.
>>               */
>> +#ifdef __x86_64__
>>              whpx_translate_cpu_breakpoints(&whpx->breakpoints, cpu, =
i);
>> +#endif
>>          }
>> +#ifdef __x86_64__
>>          /* Actually insert the breakpoints into the memory. */
>>          whpx_apply_breakpoints(whpx->breakpoints.breakpoints, cpu, =
true);
>> +#endif
>>      }
>=20
> These are still static in target/i386/whpx/whpx-all.c, so the split in =
the previous patch didn't work.  You probably want arm to *have* these =
functions, even if they're empty.
>=20
>> +#ifdef __x86_64__
>>      HRESULT hr;
>>      uint64_t exception_mask;
>>      if (whpx->step_pending ||
>> @@ -132,6 +139,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
>>                       "hr=3D%08lx.", hr);
>>          return 1;
>>      }
>> +#endif
>=20
> I'm not quite sure what this is doing, but it probably needs to be =
split out to a new function which can be specialized between =
architectures.
Hello,

Arm WHPX has no specific functionality for debugging today, but we could =
support kernel mode breakpoints via replacing them by an unhandled hvc =
#2, stubbing might be the right route to go...
>=20
>> @@ -238,8 +246,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
>>      struct whpx_state *whpx =3D &whpx_global;
>>        whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, =
cpu->cpu_index);
>> +#ifdef __x86_64__
>>      AccelCPUState *vcpu =3D cpu->accel;
>>      whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
>> +#endif
>=20
> Does the os function exist on arm?  The answer to that determines =
whether we must split this out to an architecture function or if we can =
do
>=20
>    if (vcpu->emulator) {
>        destroy
>    }

The winhvemulation header has x86-isms and isn=E2=80=99t parsable on arm =
unfortunately.

The whole winhvemulation library is x86_64 specific.=20
That said, I don=E2=80=99t think we need winhvemulation on x86 in the =
first place and it could be a good idea to get rid of the dependency =
there too.

>> @@ -414,8 +424,12 @@ static bool load_whp_dispatch_fns(HMODULE =
*handle,
>>          LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
>>          break;
>>      case WINHV_EMULATION_FNS_DEFAULT:
>> +#ifdef __x86_64__
>>          WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
>>          LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
>> +#else
>> +        abort();
>> +#endif
>=20
> Use g_assert_not_reached not abort.
>=20
> That said, it might be cleaner to split this into two functions, =
rather than select pieces of the function via an enumerator.  At which =
point I could see the entire set of emulation code staying in =
target/i386/.

There=E2=80=99s still significant shared code that might be worth =
keeping I think=E2=80=A6 will test a bit on x86 and see what makes sense =
to do=E2=80=A6

Thank you,

>=20
> r~
>=20


