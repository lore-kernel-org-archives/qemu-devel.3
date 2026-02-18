Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC4E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 07:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsbwz-0001z8-Ff; Wed, 18 Feb 2026 02:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsbwy-0001vm-4g
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 02:26:20 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsbwu-0004F9-T0
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 02:26:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 16AB080790;
 Wed, 18 Feb 2026 10:26:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:18e::1:1d] (unknown
 [2a02:6bf:8080:18e::1:1d])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7QUrNN3ArqM0-xyqDFCsK; Wed, 18 Feb 2026 10:26:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771399570;
 bh=SgMZKcgzeNU2TvwUoF8LgYIYjsIHoa4jcrS/zrJxBa4=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=c/gUwXASnlgnxaoCUUxUy3Rk1O24VfGdEmgwP5rRk2wUmQH559B8OAJHvYlH8lsNY
 WiWZvLQa7W5FtI9sAu7OIER2zjDwgDM94dYYVCGCkVRr8fRmAM3a1/Zbr592xvW4GW
 eCqPkMCO0fa12D54ZH1MQ9DPoG/CNfyHrQ6JvyaI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Content-Type: multipart/alternative;
 boundary="------------Crxyqp9k8QxmaWQjTuJI0Cxi"
Message-ID: <cca89cc5-5062-47de-94fe-2880200c2d24@yandex-team.com>
Date: Wed, 18 Feb 2026 12:26:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
 <96e57723-25e7-43ae-873d-b081e03ef72a@redhat.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <96e57723-25e7-43ae-873d-b081e03ef72a@redhat.com>
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------Crxyqp9k8QxmaWQjTuJI0Cxi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/26 14:44, Paolo Bonzini wrote:
> On 2/17/26 06:27, Sergei Heifetz wrote:
>> This patch adds the `audio` option to meson_options.txt. It is
>> propagated into Kconfig as AUDIO. It is enabled by default.
>> The corresponding `--disable-audio` and `--enable-audio` options
>> for `configure` are also added.
>>
>> For now, this option does nothing. In subsequent patches, it will
>> gradually disable audio in different places. The final goal is to stop
>> building sources from `audio/` and `hw/audio/` and other audio-related
>> files (except for some stubs). Note that this intent is different from
>> `-audio none`, which mutes audio but still compiles the audio subsystem.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   Kconfig.host      | 3 +++
>>   configure         | 4 ++++
>>   meson.build       | 3 +++
>>   meson_options.txt | 3 +++
>>   4 files changed, 13 insertions(+)
>>
>> diff --git a/Kconfig.host b/Kconfig.host
>> index 933425c74b..ec129aa4fc 100644
>> --- a/Kconfig.host
>> +++ b/Kconfig.host
>> @@ -29,6 +29,9 @@ config IVSHMEM
>>   config TPM
>>       bool
>>   +config AUDIO
>> +    bool
>> +
>>   config FDT
>>       bool
>>   diff --git a/configure b/configure
>> index 4b61fd3bbf..ff391c79a1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -762,6 +762,10 @@ for opt do
>>     ;;
>>     --wasm64-32bit-address-limit)
>>     ;;
>> +  --enable-audio) meson_option_add -Daudio=true
>> +  ;;
>> +  --disable-audio) meson_option_add -Daudio=false
>> +  ;;
>>     # everything else has the same name in configure and meson
>>     --*) meson_option_parse "$opt" "$optarg"
>>     ;;
>> diff --git a/meson.build b/meson.build
>> index 8c6c0a9a32..69aa7cd189 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -68,6 +68,8 @@ foreach target : target_dirs
>>   endforeach
>>   have_user = have_linux_user or have_bsd_user
>>   +audio_enabled = get_option('audio')
>
> You can use
>
> audio_enabled = get_option('audio').disable_auto_if(not have_system)
>
> and then replace all the "if have_system and audio_enabled" with just 
> "if audio_enabled".
>
> That said, I'd rename the variable to "have_audio" for consistency 
> with other names in meson.build.
>
> Paolo

It looks nicer this way—thanks. I’ll then make the option a feature 
rather than a boolean.

It would be `have_audio = get_option('audio').disable_auto_if(not 
have_system).*allowed()*`, though.

>
>> +
>>   ############
>>   # Programs #
>>   ############
>> @@ -3244,6 +3246,7 @@ disassemblers = {
>>   have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
>>   host_kconfig = \
>>     (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
>> +  (audio_enabled ? ['CONFIG_AUDIO=y'] : []) + \
>>     (have_tpm ? ['CONFIG_TPM=y'] : []) + \
>>     (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
>>     (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 2836156257..172ed10ead 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -71,6 +71,9 @@ option('malloc_trim', type : 'feature', value : 
>> 'auto',
>>   option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 
>> 'jemalloc'],
>>          value: 'system', description: 'choose memory allocator to use')
>>   +option('audio', type: 'boolean', value: true,
>> +       description: 'Audio support')
>> +
>>   option('kvm', type: 'feature', value: 'auto',
>>          description: 'KVM acceleration support')
>>   option('mshv', type: 'feature', value: 'auto',
>
--------------Crxyqp9k8QxmaWQjTuJI0Cxi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2/17/26 14:44, Paolo Bonzini wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:96e57723-25e7-43ae-873d-b081e03ef72a@redhat.com">On
      2/17/26 06:27, Sergei Heifetz wrote:
      <br>
      <blockquote type="cite">This patch adds the `audio` option to
        meson_options.txt. It is
        <br>
        propagated into Kconfig as AUDIO. It is enabled by default.
        <br>
        The corresponding `--disable-audio` and `--enable-audio` options
        <br>
        for `configure` are also added.
        <br>
        <br>
        For now, this option does nothing. In subsequent patches, it
        will
        <br>
        gradually disable audio in different places. The final goal is
        to stop
        <br>
        building sources from `audio/` and `hw/audio/` and other
        audio-related
        <br>
        files (except for some stubs). Note that this intent is
        different from
        <br>
        `-audio none`, which mutes audio but still compiles the audio
        subsystem.
        <br>
        <br>
        Signed-off-by: Sergei Heifetz <a class="moz-txt-link-rfc2396E" href="mailto:heifetz@yandex-team.com">&lt;heifetz@yandex-team.com&gt;</a>
        <br>
        ---
        <br>
          Kconfig.host      | 3 +++
        <br>
          configure         | 4 ++++
        <br>
          meson.build       | 3 +++
        <br>
          meson_options.txt | 3 +++
        <br>
          4 files changed, 13 insertions(+)
        <br>
        <br>
        diff --git a/Kconfig.host b/Kconfig.host
        <br>
        index 933425c74b..ec129aa4fc 100644
        <br>
        --- a/Kconfig.host
        <br>
        +++ b/Kconfig.host
        <br>
        @@ -29,6 +29,9 @@ config IVSHMEM
        <br>
          config TPM
        <br>
              bool
        <br>
          +config AUDIO
        <br>
        +    bool
        <br>
        +
        <br>
          config FDT
        <br>
              bool
        <br>
          diff --git a/configure b/configure
        <br>
        index 4b61fd3bbf..ff391c79a1 100755
        <br>
        --- a/configure
        <br>
        +++ b/configure
        <br>
        @@ -762,6 +762,10 @@ for opt do
        <br>
            ;;
        <br>
            --wasm64-32bit-address-limit)
        <br>
            ;;
        <br>
        +  --enable-audio) meson_option_add -Daudio=true
        <br>
        +  ;;
        <br>
        +  --disable-audio) meson_option_add -Daudio=false
        <br>
        +  ;;
        <br>
            # everything else has the same name in configure and meson
        <br>
            --*) meson_option_parse "$opt" "$optarg"
        <br>
            ;;
        <br>
        diff --git a/meson.build b/meson.build
        <br>
        index 8c6c0a9a32..69aa7cd189 100644
        <br>
        --- a/meson.build
        <br>
        +++ b/meson.build
        <br>
        @@ -68,6 +68,8 @@ foreach target : target_dirs
        <br>
          endforeach
        <br>
          have_user = have_linux_user or have_bsd_user
        <br>
          +audio_enabled = get_option('audio')
        <br>
      </blockquote>
      <br>
      You can use
      <br>
      <br>
      audio_enabled = get_option('audio').disable_auto_if(not
      have_system)
      <br>
      <br>
      and then replace all the "if have_system and audio_enabled" with
      just "if audio_enabled".
      <br>
      <br>
      That said, I'd rename the variable to "have_audio" for consistency
      with other names in meson.build.
      <br>
      <br>
      Paolo <br>
    </blockquote>
    <p>It looks nicer this way—thanks. I’ll then make the option a
      feature rather than a boolean. </p>
    <p>It would be `have_audio = get_option('audio').disable_auto_if(not
      have_system).<b>allowed()</b>`, though.</p>
    <blockquote type="cite"
      cite="mid:96e57723-25e7-43ae-873d-b081e03ef72a@redhat.com"><br>
      <blockquote type="cite">+
        <br>
          ############
        <br>
          # Programs #
        <br>
          ############
        <br>
        @@ -3244,6 +3246,7 @@ disassemblers = {
        <br>
          have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
        <br>
          host_kconfig = \
        <br>
            (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
        <br>
        +  (audio_enabled ? ['CONFIG_AUDIO=y'] : []) + \
        <br>
            (have_tpm ? ['CONFIG_TPM=y'] : []) + \
        <br>
            (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
        <br>
            (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
        <br>
        diff --git a/meson_options.txt b/meson_options.txt
        <br>
        index 2836156257..172ed10ead 100644
        <br>
        --- a/meson_options.txt
        <br>
        +++ b/meson_options.txt
        <br>
        @@ -71,6 +71,9 @@ option('malloc_trim', type : 'feature', value
        : 'auto',
        <br>
          option('malloc', type : 'combo', choices : ['system',
        'tcmalloc', 'jemalloc'],
        <br>
                 value: 'system', description: 'choose memory allocator
        to use')
        <br>
          +option('audio', type: 'boolean', value: true,
        <br>
        +       description: 'Audio support')
        <br>
        +
        <br>
          option('kvm', type: 'feature', value: 'auto',
        <br>
                 description: 'KVM acceleration support')
        <br>
          option('mshv', type: 'feature', value: 'auto',
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------Crxyqp9k8QxmaWQjTuJI0Cxi--

