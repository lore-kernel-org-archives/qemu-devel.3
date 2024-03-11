Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71081C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjk3P-00044F-7q; Mon, 11 Mar 2024 14:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0FuT=KR=kaod.org=clg@ozlabs.org>)
 id 1rjk3M-00040f-RL; Mon, 11 Mar 2024 14:07:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0FuT=KR=kaod.org=clg@ozlabs.org>)
 id 1rjk3K-0003uA-HW; Mon, 11 Mar 2024 14:07:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Ttl934d3Gz4wyr;
 Tue, 12 Mar 2024 05:07:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ttl9021CNz4wyh;
 Tue, 12 Mar 2024 05:06:59 +1100 (AEDT)
Message-ID: <8d1567c8-794b-4d30-96ee-28b14b5b3eff@kaod.org>
Date: Mon, 11 Mar 2024 19:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
Content-Language: en-US, fr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20231214181723.1520854-1-clg@kaod.org>
 <f3e1fefc-0df3-4339-8373-7648597a78d0@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <f3e1fefc-0df3-4339-8373-7648597a78d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=0FuT=KR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/11/24 18:46, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 14/12/23 19:17, Cédric Le Goater wrote:
>> pseries machines before version 2.11 have undergone many changes to
>> correct issues, mostly regarding migration compatibility. This is
>> obfuscating the code uselessly and makes maintenance more difficult.
>> Remove them and only keep the last version of the 2.x series, 2.12,
>> still in use by old distros.
> 
> By the time we get to QEMU v9.2, will pseries-2.12 still be used
> by old distros? (which ones btw?)

Using info from https://repology.org/api/v1/project/qemu :

alpine_3_8: 2.12.0
aur: 2.10.0, 2.7.1, 8.2.0.r1767.g91e3bf2e92
epel_7: 2.0.0
fedora_26: 2.9.0, 2.9.1
fedora_27: 2.10.0, 2.10.2
fedora_28: 2.11.1, 2.11.2
freshcode: 2.8.0
gnuguix: 2.10.2, 8.1.3
opensuse_leap_15_0: 2.11.1, 2.11.2, 3.1.1.1, 4.2.1, 5.2.0
opensuse_leap_42_3: 2.9.0, 2.9.1
openwrt_17_01_x86_64: 2.6.2
openwrt_18_06_x86_64: 2.11.1
rosa_2016_1: 2.10.1, 2.5.1.1
slackbuilds: 2.12.0, 7.2.1
slitaz_next: 2.0.2
ubuntu_14_04: 2.0.0, 2.0.0~rc1
ubuntu_16_04: 2.5
ubuntu_18_04: 2.11

Thanks to Thomas !

C.


> 
> What about also deprecating pseries-2.12 and pseries-2.12-sxxm
> which both set pre_3_0_migration, and suggest to use pseries-3.0
> instead?
> 
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   docs/about/deprecated.rst | 7 +++++++
>>   hw/ppc/spapr.c            | 1 +
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 2e1504024658..c0e22b2b568f 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -269,6 +269,13 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>>   The Nios II architecture is orphan.
>> +``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Older pseries machines before version 2.12 have undergone many changes
>> +to correct issues, mostly regarding migration compatibility. These are
>> +no longer maintained and removing them will make the code easier to
>> +read and maintain. Use versions 2.12 and above as a replacement.
> 


