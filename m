Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09938C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weXCg-0006zX-V1; Tue, 30 Jun 2026 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nowicki@posteo.net>)
 id 1weX9g-0005je-Ph
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 08:01:36 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nowicki@posteo.net>)
 id 1weX9c-0003ko-NW
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 08:01:30 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id EFB99240027
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 14:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1782820882; bh=ztG9C1CYYBqp9Bn9OVrhab1X5KM79DBSLY0Hg0z355U=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=ZoxsaEz825z9yxh6H2ChlQF3qEsIl7xkyIhJE5jRH2pzMFMtpikKgF13G2wnK6NhW
 zoTorsjnNlU4J1wYS2UV9jQSJ5PdfBmGseIzVKCOiVDPkf+ixeBBTLgMxWh3MeXGMx
 TX4eVLw5LZfxGFxk1FI3RqQAFu/++Ya/aboiVXCav3yV27y69XmCSMDzZCJqduvTPb
 vbFD9qYAMxVMTykTFw5JlGWevJnRjVU9v81kY0Wri7y9osTBwtgqLI99H5oQI/XmKd
 eCzpNZBoupvAYzPiF9X+tbhqCqeDwvH1NSFjhGWoFsFIdSWM5b2Dx/izeLLUxzlDNT
 oxSsuShs9BHBw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gqMDx10Ynz6tw1;
 Tue, 30 Jun 2026 14:01:21 +0200 (CEST)
Message-ID: <9ecec0b1-f9b3-414a-b9b0-5d2b62ecd5a9@posteo.net>
Date: Tue, 30 Jun 2026 12:01:22 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] hw/nvme: add monitor commands for inspecting state
To: Klaus Jensen <its@irrelevant.dk>,
 Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20260626112116.7621-1-mateusz.nowicki@posteo.net>
 <akObGmLY1mRSedwd@AALNPWKJENSEN.aal.scsc.local>
Content-Language: en-US
From: Mateusz Nowicki <nowicki@posteo.net>
In-Reply-To: <akObGmLY1mRSedwd@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=nowicki@posteo.net;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 08:04:37 -0400
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

CONFIG_NVME_PCI is poisoned in common code, so the schema 'if' can't work.
v4 drops it: the commands stay unconditional and hw/nvme/monitor-stub.c 
provides
the qmp_x_query_nvme[_queues]() stubs via meson if_false (like 
hw/i386/sgx-stub.c).
Verified it links with and without NVMe (x86_64 / avr).

v4: 
https://lore.kernel.org/qemu-devel/cover.1782819251.git.mateusz.nowicki@posteo.net/

Thanks,
Mateusz

On 6/30/2026 12:31 PM, Klaus Jensen wrote:
> On Jun 26 11:21, Mateusz Nowicki wrote:
>> Add two HMP commands for inspecting emulated NVMe controllers from
>> the QEMU monitor without attaching gdb to the QEMU process:
>>
>>    - 'info nvme'        - per-controller summary (PCI, identify
>>                           fields, CC/CSTS/AQA, queue counts)
>>    - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
>>                           (size, head/tail, PRP1, doorbell offset,
>>                           phase tag)
>>
>> Useful for verifying queue setup, doorbell rings, AERs held in the
>> admin SQ and similar driver/controller interaction details from a
>> running QEMU monitor.
>>
>> Changes in v3:
>>    - Gate the new x-query-nvme[-queues] commands and their 'info'
>>      counterparts behind CONFIG_NVME_PCI.  They were registered
>>      unconditionally while the implementations live in hw/nvme/, so
>>      targets built without NVMe (e.g. riscv64-softmmu) failed to link
>>      with an undefined reference to qmp_x_query_nvme.
>>    - hw/nvme/meson.build: keep the source file list alphabetically
>>      sorted (Markus).
>>
>> Changes in v2:
>>    - hw/nvme/meson.build: add the missing trailing newline (Markus).
>>    - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
>>      Armbruster on both patches.
>>
>> v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowicki@posteo.net/
>> v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowicki@posteo.net/
>>
>> Mateusz Nowicki (2):
>>    hw/nvme: add 'info nvme' HMP command
>>    hw/nvme: add 'info nvme-queues' HMP command
>>
>>   hmp-commands-info.hx |  32 ++++++++++
>>   hw/nvme/meson.build  |   2 +-
>>   hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
>>   qapi/machine.json    |  36 +++++++++++
>>   4 files changed, 208 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/nvme/monitor.c
>>
>> -- 
>> 2.53.0
>>
>>
> With this, my build complains about CONFIG_NVME_PCI being poisoned now:
>
> qapi/qapi-introspect.c:1743:13: error: attempt to use poisoned ‘CONFIG_NVME_PCI’
>   1743 | #if defined(CONFIG_NVME_PCI)
>        |             ^
> In file included from /home/kjensen/src/qemu/include/exec/poison.h:7,
>                   from /home/kjensen/src/qemu/include/qemu/osdep.h:38,
>                   from qapi/qapi-introspect.c:12:
> ./config-poison.h:277:20: note: poisoned here
>    277 | #pragma GCC poison CONFIG_NVME_PCI
>        |                    ^~~~~~~~~~~~~~~
> qapi/qapi-introspect.c:1756:13: error: attempt to use poisoned ‘CONFIG_NVME_PCI’
>   1756 | #if defined(CONFIG_NVME_PCI)
>        |             ^
> ./config-poison.h:277:20: note: poisoned here
>    277 | #pragma GCC poison CONFIG_NVME_PCI
>        |                    ^~~~~~~~~~~~~~~
>

