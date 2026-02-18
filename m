Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D884AE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 16:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsknu-0007XK-AR; Wed, 18 Feb 2026 11:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsknp-0007Wd-HO
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:53:30 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsknn-00013Y-0O
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:53:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-824a2888de5so524620b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771433601; x=1772038401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3oTEEYFzzogPp9Z8KXXqjLG1A87beJodVtcbs3uNsDc=;
 b=nU75sdIQgnMqvySg9izBexriDQgBwO4tjW5Hr1z5DDq89cz3zg7JVSwZ/IgEJHn8CT
 gJpA2NvI1XY9EXVhVe/8YDKIr62iZ42UBfrHhHVLfEFtlnLcSBz1+4CjAhmvwNBasBlW
 vX5fwlkffsaYq42umjxDL8yAAg5HrYNKN4uQVLi6eOlzd9CDk4qlngS30Gwjv+eKa/Jv
 mU7rctmA28wVhIb71PSiUf5dsnSNfro6WrAJ5XeYiso0vav9D5T8ocTkQ+JJFRgbDTHs
 e3vqvBQVylgKDroorIcW0WSlqTAkL+KhnubjvTCRjTbS2xFaxpmNqoWJnsir/20wk3Io
 IHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433601; x=1772038401;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oTEEYFzzogPp9Z8KXXqjLG1A87beJodVtcbs3uNsDc=;
 b=veILz7cOpQhhE58aVa8H6Zsn7y78UvlkyYod5wKjVAQvFLzzqaNZOU4ojp4l6Vi7LA
 /Vlro30vaRef+xiH3L357vjDkEBr4Ee26TixbEzvKpmNBU+HQ6gqArJ4YpPSrn8ho6p5
 zyOynxEobI65pFO9GvIPiLcAnt4tml7YJb4flonMzee3H7nWGurR+ORxnpK4LXb4kT5b
 aH9JXzZigoYxOq95L3t2TAAo7VKRexTWE7E2X+JYaysONZ1TUgFQu0mvwEVZRBhl+sbw
 fHqD/h2Ayauh1hbzo4SwVSLKROGz4R3C70fVBrhQx6gA308m4rl5fcGwMjdINqrR4b7W
 k3xQ==
X-Gm-Message-State: AOJu0Yw84gzivi7oEy7R9yi5lm5LQ4uRIgzMf9a2KIStOzriFHAJa129
 bkOUoZN1YjEgWzcvQFjBOXoORMCvRR0xa0UQHze2gulRBvHf2YfxfZwmH1dossLwKPCrebTaJP2
 3zf+9
X-Gm-Gg: AZuq6aKKkqiZXn9CvGvatLrplakGYgZNJr5KuVnu/ACKTrYm/gBWdmoR0dmMgs8UosI
 VsmKnmUl1AdxAoqUzu2LaDHkevZg3bOImxqUATjb5jsDFv8qX82S136nPoKqyomqpi9BVVRlqwt
 TzPsB5OuYJKFwNgWk9O5Nc3a0QnoA97JN4IgNSK7JhvVX8zJ46cIEamY5wIMFc2PhHAMDgL/8rh
 pLyp5UjQzVgiivjK9Pu95hyAsu570NpVpRYuczLJoVNsraCCC6u/ITKeRpgoYZKBiACkYGzuaia
 /9WxqhJ+44mMqGRtBpp4qIlP4Mb3i6k2ZpfZHi/XO4+CEwZdbm3hU75F1ylDitHId1gLCny/0Fd
 6sqMgF/q03AAt/NCmb/582yx65E3VZUc4qb2Acn4+8tkP/EMg8siZAxXNKpczRODAPZuP8xF4SJ
 K8gTgSsMdfHYileutzX4vztacI7QXtTbA0BqxexALQyUkf35sc0g7QoPKCTLZM/159ydjB
X-Received: by 2002:a05:6a21:6f0a:b0:38e:cac8:f964 with SMTP id
 adf61e73a8af0-394fb25fab6mr2545865637.9.1771433600777; 
 Wed, 18 Feb 2026 08:53:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e5332e0d1sm13086336a12.31.2026.02.18.08.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 08:53:20 -0800 (PST)
Message-ID: <a2723623-ce70-4e26-aeda-053b0b9e34aa@linaro.org>
Date: Wed, 18 Feb 2026 08:53:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2/12/26 3:45 PM, Pierrick Bouvier wrote:
> This series eliminates some target specifics in hw/virtio and replace them with
> runtime functions where needed, to be able to link virtio code in single-binary.
> After a first try on a series [0] doing this change and making all virtio files
> common, Richard asked to refactor this part, thus this independent series.
> 
> By diving into virtio initialization, I noticed that device_endian is always
> storing endianness of cpu associated on device reset. The root issue, is when
> dealing with target who dynamically change their endianness during execution.
> ppc64 is the main use case, as cpu always boot in BE and most of OS use LE. arm
> use case is more limited, as big endian systems are mostly dead nowadays.
> 
> Because of this, initialization is tricky, and goes through different hoops to
> have the expected value. My first approach has been to try to change this, by
> simply setting endianness on the first access. However, it fell flat, because
> current_cpu is not always available at this time.
> A second approach was to set endianness to LE by default, and change it only
> when setting device features, and potentially discovering it's a legacy virtio
> device. It brought other issues, that showed that current initialization code,
> even though it's complex, does the right thing.
> Thus, I focused on refactoring virtio_access_is_big_endian, and noticed that it
> was not even needed at this point.
> 
> Patches 1 and 2 are refactoring names to clear some confusion.
> Patch 3 eliminates virtio_access_is_big_endian, with a lenghty commit message
> explaining the change. By doing this, we remove target specifics from
> hw/virtio/virtio-access.h.
> 
> Of course, performance has been tested, and it is on par with upstream/master.
> 
> Results are on 20 runs and expressed in kIOPS:
> reference: mean=239.2 std_dev=3.48
> with_series: mean=238.1 std_dev=3.56
> 
> ---
> 
> Performance has been measured with this automated fio benchmark [1], with
> original instructions from Stefan [2].
> 
> Download artifacts and run benchmark with:
> $ wget https://github.com/pbo-linaro/qemu-linux-stack/releases/download/build/x86_64_io_benchmark-a55f2d6.tar.xz
> $ tar xvf x86_64_io_benchmark-a55f2d6.tar.xz
> $ ./run.sh /path/to/qemu-system-x86_64
> 
> [0] https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/
> [1] https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
> [2] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
> 
> Pierrick Bouvier (3):
>    hw/virtio: add virtio_vdev_is_{modern, legacy}
>    hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
>    hw/virtio: remove virtio_access_is_big_endian
> 
>   include/hw/virtio/virtio-access.h | 43 +++++++++----------------------
>   include/hw/virtio/virtio.h        | 14 ++++++++--
>   hw/net/virtio-net.c               |  6 ++---
>   hw/virtio/vhost.c                 |  6 ++---
>   hw/virtio/virtio-pci.c            | 10 +++----
>   hw/virtio/virtio.c                | 20 +++++++-------
>   6 files changed, 45 insertions(+), 54 deletions(-)
> 

polite ping on this short series, that is needed to integrate virtio in 
the future single-binary
.
Richard, does it clarify for you what the original version was doing?

Regards,
Pierrick

