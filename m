Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581E9C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnux-0002Ku-I2; Mon, 23 Jun 2025 16:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Zqu3=ZG=kaod.org=clg@ozlabs.org>)
 id 1uTnuv-0002KZ-C0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:37:25 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Zqu3=ZG=kaod.org=clg@ozlabs.org>)
 id 1uTnus-0006yb-Lu
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:37:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bR0Hx2sMGz4wcm;
 Tue, 24 Jun 2025 06:37:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bR0Ht3wrYz4wvb;
 Tue, 24 Jun 2025 06:37:14 +1000 (AEST)
Message-ID: <32c86014-8e28-4100-bb87-9072acdc01cb@kaod.org>
Date: Mon, 23 Jun 2025 22:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
 <20250620164053.579416-25-pbonzini@redhat.com>
 <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
 <4ffdb62b-8fe4-4b34-9efa-aecff7f8e77b@intel.com>
 <aFkKL-TQTcrBtXuK@redhat.com>
 <CAJSP0QUgirgNX71MwGgYbdDhVUrd3MWsetx66_+GsER8BfoSbg@mail.gmail.com>
 <aFlR6CTLRzSpS1fr@redhat.com>
 <CAJSP0QUVuXRK9nyXw=HcEV6Qi5HaE+TzVp1QOiGp7c7pX=Z=Hw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAJSP0QUVuXRK9nyXw=HcEV6Qi5HaE+TzVp1QOiGp7c7pX=Z=Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Zqu3=ZG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/23/25 20:57, Stefan Hajnoczi wrote:
> On Mon, Jun 23, 2025 at 9:09 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Mon, Jun 23, 2025 at 09:04:33AM -0400, Stefan Hajnoczi wrote:
>>> On Mon, Jun 23, 2025 at 4:04 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Mon, Jun 23, 2025 at 03:03:19PM +0800, Xiaoyao Li wrote:
>>>>> On 6/23/2025 2:43 PM, Cédric Le Goater wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 6/20/25 18:40, Paolo Bonzini wrote:
>>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>>>
>>>>>>> Add property "quote-generation-socket" to tdx-guest, which is a property
>>>>>>> of type SocketAddress to specify Quote Generation Service(QGS).
>>>>>>>
>>>>>>> On request of GetQuote, it connects to the QGS socket, read request
>>>>>>> data from shared guest memory, send the request data to the QGS,
>>>>>>> and store the response into shared guest memory, at last notify
>>>>>>> TD guest by interrupt.
>>>>>>>
>>>>>>> command line example:
>>>>>>>     qemu-system-x86_64 \
>>>>>>>       -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-
>>>>>>> socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}' \
>>>>>>>       -machine confidential-guest-support=tdx0
>>>>>>>
>>>>>>> Note, above example uses the unix socket. It can be other types,
>>>>>>> like vsock,
>>>>>>> which depends on the implementation of QGS.
>>>>>>>
>>>>>>> To avoid no response from QGS server, setup a timer for the transaction.
>>>>>>> If timeout, make it an error and interrupt guest. Define the threshold of
>>>>>>> time to 30s at present, maybe change to other value if not appropriate.
>>>>>>>
>>>>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>>> Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>>>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>>> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>> ---
>>>>>>>    qapi/qom.json                         |   8 +-
>>>>>>>    target/i386/kvm/tdx-quote-generator.h |  82 +++++++
>>>>>>>    target/i386/kvm/tdx.h                 |  10 +
>>>>>>>    target/i386/kvm/kvm.c                 |   3 +
>>>>>>>    target/i386/kvm/tdx-quote-generator.c | 300 ++++++++++++++++++++++++++
>>>>>>>    target/i386/kvm/tdx-stub.c            |   4 +
>>>>>>>    target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
>>>>>>>    target/i386/kvm/meson.build           |   2 +-
>>>>>>>    8 files changed, 582 insertions(+), 3 deletions(-)
>>>>>>>    create mode 100644 target/i386/kvm/tdx-quote-generator.h
>>>>>>>    create mode 100644 target/i386/kvm/tdx-quote-generator.c
>>>>>>
>>>>>> These changes broke the build on 32-bit host.
>>>>>>
>>>>>> Could you please send a patch to avoid compiling TDX in such environment ?
>>>>>
>>>>> Paolo is on vacation.
>>>>>
>>>>> I would like to help, but I don't have 32-bit host environment on hand. Do
>>>>> you know how to set up such environment quickly? (I tried to set up within a
>>>>> 32-bit VM but the 32-bit OS is too old and I didn't get it work to install
>>>>> the required package for building QEMU)
>>>>
>>>> You should be able to use QEMU's docker containers to get yourself a
>>>> Debian i386 container, on a x86_64 host.
>>>
>>> The cross-i686-system (Debian) build CI job succeeded:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/10423776600
>>>
>>> I wonder why the CI didn't catch the issue?
>>
>> It didn't build the x86_64 target:
>>
>>    --target-list-exclude="arm-softmmu i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
>>
>> so in turn didn't build any TDX code
> 
> Here are the targets that were built by the CI job:
> 
>    target list : avr-softmmu m68k-softmmu microblazeel-softmmu
> or1k-softmmu rx-softmmu sh4eb-softmmu tricore-softmmu xtensaeb-softmmu
> 
> 64-bit targets are not supported on 32-bit hosts since commit
> acce728cbc6c ("meson: Disallow 64-bit on 32-bit emulation"). I don't
> think the x86_64 target can be built on 32-bit hosts.
> 
> But notice that i386-softmmu is missing from the target list. That
> could be why the CI job succeeded.
> 
> Cédric: What were your ./configure options?

Just :

   --target-list=arm-softmmu,ppc-softmmu,i386-softmmu

C.



