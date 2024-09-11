Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E403EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPEC-0003xW-FN; Wed, 11 Sep 2024 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPEA-0003nW-Qs
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:25:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPE5-0002zl-Pz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:25:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2068acc8b98so64256445ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726068348; x=1726673148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KOIqyxflpQF2OIgg5Cs8RejsCarR4kHtT8bNPVM50WU=;
 b=XY4s2CpwAMYjd0V2j4W8Uc9lW/PfzT3RelJzz3qDWrIEunvwOiUfQBZVsesfCou5Eq
 xIoKoAxQwbewylV76XQp7mTUiZgnnFXIll2EEZrHIjmQ3FaQT7MWv7+3xpPdPAw5GPlC
 q7ves2KsemFRQg7y6yeXE2tGmEsBxna2s9icG/mutNbJ34KtEPFzR3OAK4WLDqavFdLy
 oevboxTTHDRxN2mHQ1DO/FR2/dKNQmkPfU0b88vCbCYh9w0kdC5WJY8XHnE/Het9dBbU
 yQK3KV1d7iOhRqfyxLgIMJM5BBFO5cYQuc2zqlWlAEvY0mzULJ71m7ZPtdxQ+b0OGH8D
 WiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068348; x=1726673148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KOIqyxflpQF2OIgg5Cs8RejsCarR4kHtT8bNPVM50WU=;
 b=JglXLI8Cb8WO2pOQ1ATE60a8jtmaJqcpqlVrChsVAmIamzwxD3YhCjEqIzagyikEDE
 zCx1TA9LWtbxroUDsGq9gj899O3jxiVIGcuvDKvS4jbW0xUceYbAehdqJOMeIb01MdJs
 ouAEqTnkOAc0jWM0LOTpqGmI6FxeMveFvzPI9eih2o6eqdHNp8or/fc8viE8Pkx/I5cH
 j7b09ACVW2/tf6KPs68XqTjp00Kzu4z/5ZrWpUvljq1UvJ7Aa8ktM4jpR4EjLbM88NFf
 y072YCXo9/ZVCwEE3JC6c9WM3AwXZioegs5ddWPPqQm17z0H7AMjLXD14jf6gp6AAimM
 D2og==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0w+UQqU5+gu3O5zM/b/W/9mLmusQSZIFmh9/gMXJEzhAQ+7ixv0YcwVjpXJn0A/UkA4+FZY9HWI3s@nongnu.org
X-Gm-Message-State: AOJu0YwVU9LMTg2OFEKi7m0Gx2uexNJD1ELMKZn0KHGp20dPNn6fmBv8
 yjN7kyH4lD91mPFHoneL4VqkfNxJPBN6PBSXNnos3WTPsf+hmvS8apf+wh5r/iM=
X-Google-Smtp-Source: AGHT+IEo3j0LjjLmX6e/pgB28NMglTb3qohZUhTxnnknsMeupJHRg8k/VIdzXloihGE5TJFpijhPog==
X-Received: by 2002:a17:902:d54f:b0:207:db0:cb6c with SMTP id
 d9443c01a7336-2074c612765mr72854645ad.34.1726068347907; 
 Wed, 11 Sep 2024 08:25:47 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076af25407sm1022925ad.41.2024.09.11.08.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:25:47 -0700 (PDT)
Message-ID: <6818337d-ba58-4051-8105-05f679f71b88@linaro.org>
Date: Wed, 11 Sep 2024 08:25:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/39] docs/spin: replace assert(0) with
 g_assert_not_reached()
Content-Language: en-US
To: "Richard W.M. Jones" <rjones@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Keith Busch <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>,
 Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
 <zkyoryho5alnyirnl7ulvh5y6tkty6koccgeygmve42uml7glu@37rkdodtlx4f>
 <bwo43ms2wi6vbeqhlc7qjwmw5jyt2btxvpph3lqn7tfol4srjf@77yusngzs6wh>
 <10d6d67a-32f6-40fc-aba9-c62a74d9d98d@maciej.szmigiero.name>
 <20240911125126.GS1450@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240911125126.GS1450@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/11/24 05:51, Richard W.M. Jones wrote:
> On Wed, Sep 11, 2024 at 02:46:18PM +0200, Maciej S. Szmigiero wrote:
>> On 11.09.2024 14:37, Eric Blake wrote:
>>> On Wed, Sep 11, 2024 at 07:33:59AM GMT, Eric Blake wrote:
>>>> On Tue, Sep 10, 2024 at 03:15:28PM GMT, Pierrick Bouvier wrote:
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>
>>>> A general suggestion for the entire series: please use a commit
>>>> message that explains why this is a good idea.  Even something as
>>>> boiler-plate as "refer to commit XXX for rationale" that can be
>>>> copy-pasted into all the other commits is better than nothing,
>>>> although a self-contained message is best.  Maybe:
>>>>
>>>> This patch is part of a series that moves towards a consistent use of
>>>> g_assert_not_reached() rather than an ad hoc mix of different
>>>> assertion mechanisms.
>>>
>>> Or summarize your cover letter:
>>>
>>> Use of assert(false) can trip spurious control flow warnings from some
>>> versions of gcc:
>>> https://lore.kernel.org/qemu-devel/54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org/
>>> Solve that by unifying the code base on g_assert_not_reached()
>>> instead.
>>>
>>
>> If using g_assert_not_reached() instead of assert(false) silences
>> the warning about missing return value in such impossible to reach
>> locations should we also be deleting the now-unnecessary "return"
>> statements after g_assert_not_reached()?
> 
> Although it's unlikely to be used on any compiler that can also
> compile qemu, there is a third implementation of g_assert_not_reached
> that does nothing, see:
> 
> https://gitlab.gnome.org/GNOME/glib/-/blob/927683ebd94eb66c0d7868b77863f57ce9c5bc76/glib/gtestutils.h#L269
> 
> Rich.
> 

Interesting.
At least gcc, clang and msvc are covered, this should be ok for most of 
the builds.

Thanks for sharing,
Pierrick

