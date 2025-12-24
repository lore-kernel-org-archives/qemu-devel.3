Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4841E7544E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 10:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMIM-0005FM-78; Wed, 24 Dec 2025 05:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYMIJ-0005EH-5E
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:40:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYMIG-0005yu-8h
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:40:38 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BOAe0bO064058
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Dec 2025 19:40:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mGz7kbVB6M7+TwacD7CpwX+W1Iw42xQqBZmr2feQMzg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1766572823; v=1;
 b=uWr0gNsBxZL+ItKwGtVeTXZaJz5ZDZspFArZBOqxaDYuaOj5JbPJb7xjwgYTGG+w
 nUvhysrzHQjRJT7PAYdNZdjqEa/A8nMlU31uw+YheugBjS4suKydlI7ighmIyKkw
 90G7xLBL5VIMGB5JVzM5hD/Qn0pfCGzKULe8ffMX0yKzIwu4Q3DYxgvaJT+mfF9W
 5awRn75sW2QmpTnWz2d7w6J6H45I8Di7AJOnFJMk6zE89Eme1iIAIW+GALsWEVCq
 M8VBX3mVHe1rWtWe+aNFTRX0Jt4hUfaoo8EgsBCJKgTNkjv+/h2HwzW/RpG2eYEe
 /e7HQE0M57+w8jStdbbjwg==
Message-ID: <9fe7f072-96df-44bc-a503-feca636030f4@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Dec 2025 19:39:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/7] console: rename `d3d_tex2d` to `native`
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-4-j@getutm.app>
 <a3f3b84a-451d-4b41-8f32-fa96ed8a608f@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSB7rV9dvrB+1=wFyAgCQt89Ez8U3fxgyWvbb5QfOJTMkA@mail.gmail.com>
 <f26efe44-0ed6-4cc7-9ca1-729a9fdad83e@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSDh7Q-_+FgRvCs6B5SGCwEgk8siqupVbR=wCUtVJxOiGg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CA+E+eSDh7Q-_+FgRvCs6B5SGCwEgk8siqupVbR=wCUtVJxOiGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/24/25 16:56, Joelle van Dyne wrote:
> On Tue, Dec 23, 2025 at 10:29 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/12/20 1:16, Joelle van Dyne wrote:
>>> On Wed, Dec 3, 2025 at 10:41 PM Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>
>>>> On 2025/12/03 13:07, Joelle van Dyne wrote:
>>>>> In order to support native texture scanout beyond D3D, we make this more
>>>>> generic allowing for multiple native texture handle types.
>>>>>
>>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>>>> ---
>>>>>     include/ui/console.h          | 22 +++++++++++++++++++---
>>>>>     include/ui/gtk.h              |  4 ++--
>>>>>     include/ui/sdl2.h             |  2 +-
>>>>>     hw/display/virtio-gpu-virgl.c | 10 +++++++---
>>>>>     ui/console.c                  |  8 ++++----
>>>>>     ui/dbus-console.c             |  2 +-
>>>>>     ui/dbus-listener.c            |  8 ++++----
>>>>>     ui/egl-headless.c             |  2 +-
>>>>>     ui/gtk-egl.c                  |  2 +-
>>>>>     ui/gtk-gl-area.c              |  2 +-
>>>>>     ui/sdl2-gl.c                  |  2 +-
>>>>>     ui/spice-display.c            |  2 +-
>>>>>     12 files changed, 43 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/include/ui/console.h b/include/ui/console.h
>>>>> index 98feaa58bd..25e45295d4 100644
>>>>> --- a/include/ui/console.h
>>>>> +++ b/include/ui/console.h
>>>>> @@ -131,6 +131,22 @@ struct QemuConsoleClass {
>>>>>         ObjectClass parent_class;
>>>>>     };
>>>>>
>>>>> +typedef enum ScanoutTextureNativeType {
>>>>> +    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
>>>>> +    SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
>>>>> +} ScanoutTextureNativeType;
>>>>> +
>>>>> +typedef struct ScanoutTextureNative {
>>>>> +    ScanoutTextureNativeType type;
>>>>> +    union {
>>>>> +        void *d3d_tex2d;
>>>>> +    } u;> +} ScanoutTextureNative;
>>>>
>>>> Instead, I suggest:
>>>>
>>>> typedef struct ScanoutTextureNative {
>>>>        ScanoutTextureNativeType type;
>>>>        void *handle;
>>>> } ScanoutTextureNative;
>>>>
>>>> ...to align with the definition of struct
>>>> virgl_renderer_resource_info_ext and
>>>> virgl_renderer_create_handle_for_scanout(), which do not add a field for
>>>> each type (except the one for the backward compatibility).
>>> I've updated virglrenderer to use a union as well. Since we are
>>> passing ScanoutTextureNative around byval and it can grow with
>>> additional platform support, I think it would be better to keep it as
>>> a union.
>>
>> I don't think using a union for virglrenderer is a good idea because
>> adding another member to the union can change its size and cause an ABI
>> breakage. Sticking to void * is the safest choice. We rely on void * to
>> represent platform-specific types anyway so there is practically no type
>> safetey here, unfortunately.
> That's fair, we can use a struct in virglrenderer. However, in QEMU if
> we are passing byval and a struct (once increased in size) could lead
> to needless copying.

What I suggest for virlgrenderer is basically as folllows:

struct virgl_renderer_resource_info_ext {
    int version;
    struct virgl_renderer_resource_info base;
    bool has_dmabuf_export;
    int planes;
    uint64_t modifiers;
    void *d3d_tex2d;
    union {
       /* this is for backwards compatibility */
       void *d3d_tex2d;
       void *native_handle;
    };
    enum virgl_renderer_native_handle_type native_type;
};

For QEMU:
typedef struct ScanoutTextureNative {
     enum virgl_renderer_native_handle_type type;
     void *handle;
} ScanoutTextureNative;

... and you'll get the stable ABI for virglrenderer and zero-copy with 
handle.

Regards,
Akihiko Odaki

