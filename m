Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F8DC021A1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 21:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thET3-0005mw-PD; Sun, 09 Feb 2025 16:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1thET1-0005mc-1X
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:03:51 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1thESy-0002OU-NP
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:03:50 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739135011; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jP+Ra9Qpj97NsV+8lERLtbcZYIk0ixnzZy/9qzMfVC4k8UgtCaNPHxGnhe7FUl7IMH+sJVneXaVyN1QLaMhL2YBmdEgVvUoX/T2nbz9AxE7d16xaE2VGlaBg9lyNCtTeyFXhmzqVGM7MWxfhgQzU4G7W9UgTy+tg5rNJWj0i8B8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739135011;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3Fu9JjiMn5+UQdJCTkYIkKy2eNEHB/ssPhgUPc9udoY=; 
 b=Y4GC/lumAU9YUwUt0tLyBVjX4yp+cF52urasjpqOsjLGxs6aHALa3Nd4P0y8dvY0bWa13JIic4h+8nXyfcgXXY6UPk2/qnK893hHYHvPse6B+GtxwHiAdxg/J+AJK85ox+1r0xDScRw5oimuw0iyQBRj85LqxYIdTjYJtObkKTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739135011; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3Fu9JjiMn5+UQdJCTkYIkKy2eNEHB/ssPhgUPc9udoY=;
 b=I5C5WAx4gQh/8unfHgf8N7n4jtkSqIGMVz92roUs0d1hCB5b4VcUbv5mTR3jMBD+
 E8BKC6FTVQnX/RgVBl50imtrYGYgiuRTvwFY36tYn/KOjZMMod0WDpHN+sHc9BQ7TdH
 ytxGUPvsqJaCSNhGvDfuKREf5BS2glYGmeBgYbKc=
Received: by mx.zohomail.com with SMTPS id 1739135008024960.7997563115566;
 Sun, 9 Feb 2025 13:03:28 -0800 (PST)
Message-ID: <59f70c1d-4c66-4440-a102-5f478749c8f3@collabora.com>
Date: Mon, 10 Feb 2025 00:03:20 +0300
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <fdd8b7ca-e4ad-405d-a58e-fbcb82183ec8@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2/6/25 08:41, Akihiko Odaki wrote:
> On 2025/02/06 2:40, Dmitry Osipenko wrote:
>> On 2/3/25 08:31, Akihiko Odaki wrote:
>> ...
>>>> Requirements don't vary much. For example virglrenderer minigbm support
>>>> is mandatory for crosvm, while for QEMU it's not.
>>>
>>> Is that true? It seems that virglrenderer uses builds without minigbm
>>> support to run tests on GitLab CI.
>>
>> CI is running in a headless mode using software renderer. For a
>> full-featured crosvm support running on a baremetal, minigbm should be
>> needed, along with other downstream features.
> 
> That makes sense.
> 
> Based on your input, for QEMU, I don't think we need a separate
> documentation to describe libvirglrenderer's build flags though crosvm
> should have some documentation saying it requires minigbm.
> 
>>
>>> Anyway, if there is any variance in the build procedure, that may
>>> justify having a separate build instruction in QEMU tree to avoid
>>> confusion. Otherwise, it's better to have a documentation shared with
>>> other VMMs.
>>>
>>>>
>>>>> I'm not entirely sure the documentation will stay as is for that long.
>>>>> The requirements of Intel native context refer to merge requests that
>>>>> can be merged sooner or later. Asahi may need more updates if you
>>>>> document it too because its DRM ABI is still unstable.
>>>>
>>>> The unstable parts of course will need to be updated sooner, but the
>>>> stable should be solid for years. I expect that about a year later
>>>> requirements will need to be revisited.
>>>>
>>>
>>> It will be some burden in the future. Now you are adding this
>>> documentation just for QEMU, but crosvm and libkrun may gain similar
>>> documentation. The DRM native context support for Intel and Asahi is in
>>> development, and I guess nvk will support it someday.
>>>
>>> So, a very rough estimation of future documentation updates will be:
>>> (number of VMMs) * (number of DRM native contexts in development)
>>> = 3 * 3
>>> = 9
>>>
>>> That's manageable but suboptimal.
>>
>> I don't mind deferring the doc addition if that's preferred. Either way
>> is fine with me. Yet it's better to have doc than not.
> 
> My suggestion is not to defer the addition, but to add it to Mesa, which
> does not require deferring.
> 
>>
>> In my view crosvm and libkrun exist separately from QEMU, they serve a
>> different purpose. Majority of QEMU users likely never heard about those
>> other VMMs. A unified doc won't be a worthwhile effort, IMO.
>>
> 
> When evaluating the utility of a unified documentation, Whether the
> majority of Mesa/Virgl users care VMMs other than QEMU matters more. And
> I think it is true; libkrun and crosvm are excellent options for
> graphics-accelerated VMs.
> 
> If we have a unified documentation, any VM can point to it for the build
> instruction of Mesa and virglrenderer. Once that's done, QEMU users who
> want graphics acceleration can take the following steps:
> 1. See docs/system/devices/virtio-gpu.rst
> 2. Figure out that they need Mesa and virglrenderer
> 3. Click the link to the unified documentation
> 4. Build Mesa and virglrenderer accordingly
> 
> No other VMMs will bother them in this procedure.

Will see. For the starter, adding example build flags to QEMU doesn't
hurt, it's a very minimal information. Later on, if and when all
relevant Mesa/virglrenderer doc pages will appear, it won't be a problem
replace QEMU flags with the links. Please let's do it step-by-step, one
step at a time :)

-- 
Best regards,
Dmitry

