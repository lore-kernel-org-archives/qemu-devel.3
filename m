Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE39C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkH51-0002e7-MQ; Tue, 18 Feb 2025 01:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tkH50-0002Xn-8Q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:27:38 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tkH4v-0004VS-H1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:27:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739860038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q2cMG1nfxmPVaCBdZQCMfdSgj9qRqz81jjU0eaPAp9evLeF0rcAI3vPePvVXTj0WmnexZrfhbXh1JLoMyWHG/QyKg02gtOtucPqJoxDN+zpB355v9ikl0TJi+DCxjRl+SSwvAsYrounaYqy+tezGsj2mRVzlO9PXopbrrxu+Hyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739860038;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vVMsX+wubt1Dg9va3EwUPrJqL6sabED33dTj9Ow0JA8=; 
 b=VztEO9K6VEdXpeRC2STOhl8cr6SzL11PvUsZ3ZUoYCIqKvnnFqoEcKPhn7FMpIKdOstKrCbZDraokOnBORWSHxS9wxFNQg1/t3mfWu+rXJB74J1e2jHNPOFTDCSZFDa50uqbbys8IYxqHg335CsrSlWrmiE+yYgh+x8CCXKEvd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739860038; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vVMsX+wubt1Dg9va3EwUPrJqL6sabED33dTj9Ow0JA8=;
 b=O0upR/1D4fIovrAusVgCYY8O7BF+gIL46inwPSjUdliWfX5iruvxP7HRMXXTjXU6
 6UAphJIC1YGqK3JOG9l8KnfiGJ0cRewuy39yXbu3Pya4zT2L6ryc9QV+MEsITN6DAYz
 2JJ/666azBr3Cn4OOBLLIebWYZxtZ5Q04BkmqH7g=
Received: by mx.zohomail.com with SMTPS id 1739860036120617.7497462384239;
 Mon, 17 Feb 2025 22:27:16 -0800 (PST)
Message-ID: <6714cca4-7367-4d99-84b6-c83df80140e6@collabora.com>
Date: Tue, 18 Feb 2025 09:27:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
 <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
 <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
 <86dce86b-03bf-4abe-b825-1341e93eb88d@daynix.com>
 <920043a8-9294-4b40-8d8e-3611727e4cd2@collabora.com>
 <0f88994f-1a93-4049-addc-a62e8ca49904@daynix.com>
 <d85f6669-8c46-4678-85d6-59240935d197@collabora.com>
 <fdd8b7ca-e4ad-405d-a58e-fbcb82183ec8@daynix.com>
 <59f70c1d-4c66-4440-a102-5f478749c8f3@collabora.com>
 <a8fc06f0-0197-4394-bac4-733f3fcef103@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <a8fc06f0-0197-4394-bac4-733f3fcef103@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/13/25 07:32, Akihiko Odaki wrote:
> On 2025/02/10 6:03, Dmitry Osipenko wrote:
>> On 2/6/25 08:41, Akihiko Odaki wrote:
>>> On 2025/02/06 2:40, Dmitry Osipenko wrote:
>>>> On 2/3/25 08:31, Akihiko Odaki wrote:
>>>> ...
>>>>>> Requirements don't vary much. For example virglrenderer minigbm
>>>>>> support
>>>>>> is mandatory for crosvm, while for QEMU it's not.
>>>>>
>>>>> Is that true? It seems that virglrenderer uses builds without minigbm
>>>>> support to run tests on GitLab CI.
>>>>
>>>> CI is running in a headless mode using software renderer. For a
>>>> full-featured crosvm support running on a baremetal, minigbm should be
>>>> needed, along with other downstream features.
>>>
>>> That makes sense.
>>>
>>> Based on your input, for QEMU, I don't think we need a separate
>>> documentation to describe libvirglrenderer's build flags though crosvm
>>> should have some documentation saying it requires minigbm.
>>>
>>>>
>>>>> Anyway, if there is any variance in the build procedure, that may
>>>>> justify having a separate build instruction in QEMU tree to avoid
>>>>> confusion. Otherwise, it's better to have a documentation shared with
>>>>> other VMMs.
>>>>>
>>>>>>
>>>>>>> I'm not entirely sure the documentation will stay as is for that
>>>>>>> long.
>>>>>>> The requirements of Intel native context refer to merge requests
>>>>>>> that
>>>>>>> can be merged sooner or later. Asahi may need more updates if you
>>>>>>> document it too because its DRM ABI is still unstable.
>>>>>>
>>>>>> The unstable parts of course will need to be updated sooner, but the
>>>>>> stable should be solid for years. I expect that about a year later
>>>>>> requirements will need to be revisited.
>>>>>>
>>>>>
>>>>> It will be some burden in the future. Now you are adding this
>>>>> documentation just for QEMU, but crosvm and libkrun may gain similar
>>>>> documentation. The DRM native context support for Intel and Asahi
>>>>> is in
>>>>> development, and I guess nvk will support it someday.
>>>>>
>>>>> So, a very rough estimation of future documentation updates will be:
>>>>> (number of VMMs) * (number of DRM native contexts in development)
>>>>> = 3 * 3
>>>>> = 9
>>>>>
>>>>> That's manageable but suboptimal.
>>>>
>>>> I don't mind deferring the doc addition if that's preferred. Either way
>>>> is fine with me. Yet it's better to have doc than not.
>>>
>>> My suggestion is not to defer the addition, but to add it to Mesa, which
>>> does not require deferring.
>>>
>>>>
>>>> In my view crosvm and libkrun exist separately from QEMU, they serve a
>>>> different purpose. Majority of QEMU users likely never heard about
>>>> those
>>>> other VMMs. A unified doc won't be a worthwhile effort, IMO.
>>>>
>>>
>>> When evaluating the utility of a unified documentation, Whether the
>>> majority of Mesa/Virgl users care VMMs other than QEMU matters more. And
>>> I think it is true; libkrun and crosvm are excellent options for
>>> graphics-accelerated VMs.
>>>
>>> If we have a unified documentation, any VM can point to it for the build
>>> instruction of Mesa and virglrenderer. Once that's done, QEMU users who
>>> want graphics acceleration can take the following steps:
>>> 1. See docs/system/devices/virtio-gpu.rst
>>> 2. Figure out that they need Mesa and virglrenderer
>>> 3. Click the link to the unified documentation
>>> 4. Build Mesa and virglrenderer accordingly
>>>
>>> No other VMMs will bother them in this procedure.
>>
>> Will see. For the starter, adding example build flags to QEMU doesn't
>> hurt, it's a very minimal information. Later on, if and when all
>> relevant Mesa/virglrenderer doc pages will appear, it won't be a problem
>> replace QEMU flags with the links. Please let's do it step-by-step, one
>> step at a time :)
>>
> 
> To be honest, I'm concerned that you may be using QEMU as a staging tree
> for Mesa/virglrenderer. Submitting a documentation to QEMU as a
> preparation to submit one to Mesa is not OK.
> 
> You shouldn't submit a documentation to QEMU if upstream
> Mesa developers rejects it because it contains too little information.
> It may not hurt QEMU, but still lacks a valid reasoning.

Don't understand what you're talking about here. I may remind that this
is not my QEMU doc patch to begin with, hence it has nothing to do with
Mesa nor with virglrenderer. Alex wants to help QEMU users by adding
more QEMU documentation.

Maybe you're also not very familiar with the Mesa development process.
This is okay, no problems.

> Mesa should have more people who care virtio-gpu as there are people
> using other VMMs and perhaps it may be difficult to convince them to add
> a documentation like this. It is still not a good idea to workaround
> that by adding one to QEMU. The documentation submitted to QEMU is
> mostly reviewed only by me, who barely used Venus and DRM native
> contexts, which is not a good sign. Getting reviewed by more people is
> one of the advantage of open-source contribution after all so let's keep
> it.
> 
> I can help you add a documentation to Mesa by reviewing and supporting
> one if you want, but I cannot support adding one to QEMU if it's done to
> avoid a potential challenge to add it to Mesa.

Thanks a lot! More reviewers always good to have, will definitely ping
you. Right now writing more Mesa documentation isn't a priority, hence
will take time to get to it.

-- 
Best regards,
Dmitry

