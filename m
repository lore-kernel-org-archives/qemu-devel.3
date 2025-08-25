Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D1BCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYGg-0003tn-KX; Mon, 25 Aug 2025 10:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uqYGY-0003ri-MK; Mon, 25 Aug 2025 10:33:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uqYGN-0001lr-Pz; Mon, 25 Aug 2025 10:33:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6AA0056F303;
 Mon, 25 Aug 2025 16:33:27 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 57juYtJ6uTE7; Mon, 25 Aug 2025 16:33:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 45BFE56F2CA; Mon, 25 Aug 2025 16:33:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4368B56F2AE;
 Mon, 25 Aug 2025 16:33:25 +0200 (CEST)
Date: Mon, 25 Aug 2025 16:33:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Thomas Huth <thuth@redhat.com>, Glenn Miles <milesg@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@redhat.com, 
 npiggin@gmail.com, rathc@linux.ibm.com, richard.henderson@linaro.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
In-Reply-To: <e946e0f7-cc9f-40fa-bd41-3044510ce261@linux.ibm.com>
Message-ID: <cee8e481-8cfa-a86c-bca6-10ac3fbcffb6@eik.bme.hu>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
 <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
 <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
 <fd6f2788-b1a8-41af-88b5-9eb2ebdfd9d8@redhat.com>
 <e946e0f7-cc9f-40fa-bd41-3044510ce261@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-248834919-1756132405=:84819"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-248834919-1756132405=:84819
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 25 Aug 2025, Harsh Prateek Bora wrote:
> On 8/25/25 17:52, Thomas Huth wrote:
>> On 25/08/2025 14.08, Harsh Prateek Bora wrote:
>>> On 8/25/25 17:28, Thomas Huth wrote:
>>>> As I said, qemu-system-ppc64 is currently a full superset of qemu-system- 
>>>> ppc. The ppc64 binary contains all the 32-bit code, you can perfectly run 
>>>> a "g3beige" or "bamboo" machine with qemu-system-ppc64, too. By disabling 
>>>> the ppe42 code in the ppc64 binary, this would now introduce an execption 
>>>> to that unwritten rule, so I'd expect that we'd not rather want to do 
>>>> this now.
>>> 
>>> My understanding is that above holds true only for default builds which
>>> builds all targets. We certainly do not build 32 bit ppc code when using
>>> --configure target-list=ppc64-softmmu. (we have ppc-softmmu for 32 bit 
>>> though)

We do build 32-bit machines in ppc64-softmmu but leave out 64-bit from 
ppc-softmmu so it's only one way.

>> Just give it a try:
>>
>>   ./configure --target-list=ppc64-softmmu --disable-docs
>>   make -j$(nproc)
>>   ./qemu-system-ppc64 -M g3beige
>> 
>> ... works perfectly fine for me.
>> 
> This would work because the respective code is not restricted with #ifndef 
> TARGET_PPC64.
>
> However, there are instance like below in hw/ppc/mac_oldworld.c:
>
> static void heathrow_class_init(ObjectClass *oc, const void *data)
> {
>    MachineClass *mc = MACHINE_CLASS(oc);
>    FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
>
>    mc->desc = "Heathrow based PowerMac";
>    mc->init = ppc_heathrow_init;
>    mc->block_default_type = IF_IDE;
>    /* SMP is not supported currently */
>    mc->max_cpus = 1;
> #ifndef TARGET_PPC64
>    mc->is_default = true;
> #endif

This is only because the default machine for ppc64-softmmu is different 
than for ppc-softmmu as the 64-bit machines don't exist in ppc-softmmu but 
ppc64-softmmu had different default machine before machines from 
qemu-system-ppc got included in qemu-system-ppc64 so it kept that. (Looks 
like the default used to be mac_newworld before commit 159f8286b760dea but 
wasn't changed to match but to something else.) The default machines are 
arbitrary, we could make "none" the default and always require users to 
supply -machine but that would break existing command lines so this wasn't 
done.

> Similarly, we have multiple instances with #else block for #ifdef
> TARGET_PPC64 which doesnt get compiled with ppc64-softmmu, but only with
> ppc-softmmu meant for 32-bit targets. See target/ppc/excp_helper.c for 
> example.

This is again leaving out 64-bit code from ppc-softmmu but as Thomas says 
32-bit machines are always included in qemu-softmmu-ppc64. I can't find 
the commit which changed this, previously we had these to be separate and 
since some types are different in ppc64-softmmu it wasn't clear if that 
could cause any problems for 32-bit CPUs and machines so ppc-softmmu was 
kept until that's cleaned up which never happened. There are also some 
pecularities in some machines like mac_newworld that behaves differently 
in qemu-system-ppc and qemu-system-ppc64 and the potentially lower 
performance of qemu-system-ppc64 in emulating 32-bit machines which is why 
we still have ppc-softmmu.

Regards,
BALATON Zoltan

> regards,
> Harsh
>
>> AFAIK we don't have a switch to disable 32-bit code in the ppc64 binary.
>>
>>   Thomas
>> 
>
>
--3866299591-248834919-1756132405=:84819--

