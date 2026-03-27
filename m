Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A2C10BA45D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w63Ms-0002ge-FT; Fri, 27 Mar 2026 05:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w63Mn-0002fw-AK; Fri, 27 Mar 2026 05:20:34 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w63Ml-0003tc-0n; Fri, 27 Mar 2026 05:20:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D36D6C01F0;
 Fri, 27 Mar 2026 12:20:25 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b75::1:32] (unknown
 [2a02:6bf:8080:b75::1:32])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MKSVJK0Ak0U0-hmu59Exp; Fri, 27 Mar 2026 12:20:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774603225;
 bh=CaONCLTcWzwZf1MsIrl9HADrWWSoUv7eeGeRdWqX9Qc=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=SLidaGRF8/ll3Cbanr3eebP3Q5m3TDzHoZGFkglQh6KJRWN8XxZwmz3SAjS3jWAGB
 cBL1kASBxeVLXY//oHmWtgZMc5+I5oTODfJWuWEdv2SnxdADyflkINSYKDjmOMf9YE
 nu+Y9D9jGXWyMHjQImfdXe7BUTlpAsxEQrYuSWAE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------VHnosBjO6eK5FqOMIoSdQ254"
Message-ID: <35ca08b4-b989-44df-8491-610752146252@yandex-team.ru>
Date: Fri, 27 Mar 2026 14:20:22 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vhost-user-blk: fix compatibility with older qemu
 versions
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@lists.linux.dev,
 zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Milan Zamazal <mzamazal@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260311084728.751169-1-dtalexundeer@yandex-team.ru>
 <20260326155514.GF758087@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260326155514.GF758087@fedora>
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
--------------VHnosBjO6eK5FqOMIoSdQ254
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/26/26 20:55, Stefan Hajnoczi wrote:
> On Wed, Mar 11, 2026 at 01:47:24PM +0500, Alexandr Moshkov wrote:
>> v1 -> v2:
>> - reorganize commits: make refactor commits first, then core semantic change
>> - add additional pre_save check for inflight migration possibility
>>
>> ---
>>
>> This is a small continuation of my series about inflight migration for vhost-user-blk.
>>
>> This series is designed to solve the problem of compatibility with older versions of qemu, where this feature has not yet been introduced (for example, if we want to downgrade versions due to some problems).
>>
>> In the current version for vhost-user-blk, this feature is enabled using the parameter and further migration of the inflight region will depend on whether the vhost-user has accepted the new protocol feature or not. This creates an inconvenient dependency, because there is no way to disable this feature without reconnecting to the backend.
>> This series slightly changes the semantics of the introduced protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature adds a new parameter for GET_VRING_BASE message - skip_drain, which allows to control drain in-flight requests on the backend.
>>
>> Thus, user can enable or disable inflight-migration param for vhost-user-blk to maintain compatibility with older versions of QEMU.
> Can you describe what the user needs to do in more detail?
>
> While the patch series introduces a way to tell the vhost-user back-end
> whether or not to use inflight migration at runtime, I don't see a way
> for the user to enable/disable inflight migration at runtime in QEMU. So
> how does the user migrate back to an old QEMU if the current VM was
> launched with inflight-migration=on?
>
> Stefan

The idea was that the inflight-migration parameter can be turned off in 
runtime via qom-set. Thiswill setthe 
parameterskip_drain=falseinvhost_user_blk_stop(),thenGET_VRING_BASEwill 
be sentwiththe parametersetto 0,andthe backendserver 
willoperateaccordingto the oldscenario(waitfor the drain).

However, Ihave nowdiscoveredthatI cannotsetthe parameterdueto:

```
{'error': {'class': 'GenericError', 'desc': "Attempt to set property 
'inflight-migration' on anonymous device (type 'vhost-user-blk') after 
it was realized"}}
```
So, I'll fix that too :)

--------------VHnosBjO6eK5FqOMIoSdQ254
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/26/26 20:55, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260326155514.GF758087@fedora">
      <pre wrap="" class="moz-quote-pre">On Wed, Mar 11, 2026 at 01:47:24PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">v1 -&gt; v2:
- reorganize commits: make refactor commits first, then core semantic change
- add additional pre_save check for inflight migration possibility

---

This is a small continuation of my series about inflight migration for vhost-user-blk.

This series is designed to solve the problem of compatibility with older versions of qemu, where this feature has not yet been introduced (for example, if we want to downgrade versions due to some problems).

In the current version for vhost-user-blk, this feature is enabled using the parameter and further migration of the inflight region will depend on whether the vhost-user has accepted the new protocol feature or not. This creates an inconvenient dependency, because there is no way to disable this feature without reconnecting to the backend.
This series slightly changes the semantics of the introduced protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature adds a new parameter for GET_VRING_BASE message - skip_drain, which allows to control drain in-flight requests on the backend.

Thus, user can enable or disable inflight-migration param for vhost-user-blk to maintain compatibility with older versions of QEMU.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Can you describe what the user needs to do in more detail?

While the patch series introduces a way to tell the vhost-user back-end
whether or not to use inflight migration at runtime, I don't see a way
for the user to enable/disable inflight migration at runtime in QEMU. So
how does the user migrate back to an old QEMU if the current VM was
launched with inflight-migration=on?

Stefan</pre>
    </blockquote>
    <p>The idea was that the inflight-migration parameter can be turned
      off in runtime via qom-set. <span class="YPkS7KbdpWfGdYKd3QB9"
      data-src-align="0:3" style="white-space: pre-wrap;">
This</span><span style="white-space: pre-wrap;"> will </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="4:8"
      style="white-space: pre-wrap;">set</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="13:8"
      style="white-space: pre-wrap;">parameter</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="22:10"
      style="white-space: pre-wrap;">skip_drain</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="33:1"
      style="white-space: pre-wrap;">=</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="35:5"
      style="white-space: pre-wrap;">false</span><span
      style="white-space: pre-wrap;"> in</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="43:19"
      style="white-space: pre-wrap;">vhost_user_blk_stop</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="62:1"
      style="white-space: pre-wrap;">(</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="63:1"
      style="white-space: pre-wrap;">)</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="64:1"
      style="white-space: pre-wrap;">,</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="66:5"
      style="white-space: pre-wrap;">then</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="72:14"
      style="white-space: pre-wrap;">GET_VRING_BASE</span><span
      style="white-space: pre-wrap;"> will be </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="87:10"
      style="white-space: pre-wrap;">sent</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="98:1"
      style="white-space: pre-wrap;">with</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="100:10"
      style="white-space: pre-wrap;">parameter</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="111:6"
      style="white-space: pre-wrap;">set</span><span
      style="white-space: pre-wrap;"> to </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="118:1"
      style="white-space: pre-wrap;">0</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="119:1"
      style="white-space: pre-wrap;">,</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="121:1"
      style="white-space: pre-wrap;">and</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="123:6"
      style="white-space: pre-wrap;">backend</span><span
      style="white-space: pre-wrap;"> server </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="130:5"
      style="white-space: pre-wrap;">will</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="136:11"
      style="white-space: pre-wrap;">operate</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="148:2"
      style="white-space: pre-wrap;">according</span><span
      style="white-space: pre-wrap;"> to the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="151:7"
      style="white-space: pre-wrap;">old</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="159:8"
      style="white-space: pre-wrap;">scenario</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="168:1"
      style="white-space: pre-wrap;">(</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="169:10"
      style="white-space: pre-wrap;">wait</span><span
      style="white-space: pre-wrap;"> for the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="180:6"
      style="white-space: pre-wrap;">drain</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="186:1"
      style="white-space: pre-wrap;">)</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="187:1"
      style="white-space: pre-wrap;">.</span></p>
    <p><span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="0:6"
      style="white-space: pre-wrap;">However</span><span
      style="white-space: pre-wrap;">, </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="14:1"
      style="white-space: pre-wrap;">I</span><span
      style="white-space: pre-wrap;"> have </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="7:6"
      style="white-space: pre-wrap;">now</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="16:9"
      style="white-space: pre-wrap;">discovered</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="26:3"
      style="white-space: pre-wrap;">that</span><span
      style="white-space: pre-wrap;"> I </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="30:7"
      style="white-space: pre-wrap;">cannot</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="38:9"
      style="white-space: pre-wrap;">set</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="48:8"
      style="white-space: pre-wrap;">parameter</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="57:2"
      style="white-space: pre-wrap;">due</span><span
      style="white-space: pre-wrap;"> to</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="63:6"
      style="white-space: pre-wrap;">: </span></p>
    <p>```<br>
      {'error': {'class': 'GenericError', 'desc': "Attempt to set
      property 'inflight-migration' on anonymous device (type
      'vhost-user-blk') after it was realized"}}<br>
      ```<br>
      So, I'll fix that too :)</p>
  </body>
</html>

--------------VHnosBjO6eK5FqOMIoSdQ254--

