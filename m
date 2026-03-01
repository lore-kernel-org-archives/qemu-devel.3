Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D456FD0066
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 12:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwfzR-0000ZX-8E; Sun, 01 Mar 2026 07:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwfzI-0000YS-Te; Sun, 01 Mar 2026 07:33:37 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwfzG-0008KY-GK; Sun, 01 Mar 2026 07:33:32 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3TNANMqRpKgGhAA--.22152S2;
 Sun, 01 Mar 2026 20:33:18 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.118.211])
 by mail (Coremail) with SMTP id AQAAfwA3jusMMqRpaCweAA--.37813S2;
 Sun, 01 Mar 2026 20:33:16 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------S0LAryhZODTeHls3SfyW1nz5"
Message-ID: <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
Date: Sun, 1 Mar 2026 20:33:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
 <aaGu5v0To65M5LkB@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aaGu5v0To65M5LkB@google.com>
X-CM-TRANSID: AQAAfwA3jusMMqRpaCweAA--.37813S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWmiCd8FiAACsW
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZr17JF4xGF17Ar17KryxAFb_yoWDtFb_uw
 4vq3Z3Gw4DArsxXrn3KFsxXrs3G3y7Wa4UXrWFq343ArW3WFZrJFZ7trZ5XrW3Jw4F9F1j
 y3yDuay7uFySqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
--------------S0LAryhZODTeHls3SfyW1nz5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mostafa,

On 2026/2/27 PM10:49, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
>> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
>> and return CERROR_ILL when stage-1 translation is not implemented,
>> matching the architecture requirement (IHI 0070G.b, page 176).
>>
>> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
> This is a separate fix, it can be sent standalone to make this series
> smaller, similarly the first patch.


For #1, #2 and #19 commit (this one), since I’m not fully sure about the 
expected process here, should I resend these already Reviewed-by fixes 
as standalone patch respectively right now,  and try to get them merged 
first?


> Also the "Fixes" comment is not accurate, that was probably broken from
> the stage-2 implementation which was added later.


I'll remove "Fixes" when resending this commit.


> Reviewed-by: Mostafa Saleh<smostafa@google.com>
>
> Thanks,
> Mostafa


Thanks for your review.

Tao



--------------S0LAryhZODTeHls3SfyW1nz5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Mostafa,</p>
    <div class="moz-cite-prefix">On 2026/2/27 PM10:49, Mostafa Saleh
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aaGu5v0To65M5LkB@google.com">
      <pre wrap="" class="moz-quote-pre">On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
and return CERROR_ILL when stage-1 translation is not implemented,
matching the architecture requirement (IHI 0070G.b, page 176).

Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
Signed-off-by: Tao Tang <a class="moz-txt-link-rfc2396E" href="mailto:tangtao1634@phytium.com.cn">&lt;tangtao1634@phytium.com.cn&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is a separate fix, it can be sent standalone to make this series
smaller, similarly the first patch.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>For #1, #2 and #19 commit (this one), since I’m not fully sure
      about the expected process here, should I resend these already
      Reviewed-by fixes as standalone patch respectively right now,  and
      try to get them merged first?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:aaGu5v0To65M5LkB@google.com">
      <pre wrap="" class="moz-quote-pre">
Also the "Fixes" comment is not accurate, that was probably broken from
the stage-2 implementation which was added later.
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I'll remove "Fixes" when resending this commit.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:aaGu5v0To65M5LkB@google.com">
      <pre wrap="" class="moz-quote-pre">
Reviewed-by: Mostafa Saleh <a class="moz-txt-link-rfc2396E" href="mailto:smostafa@google.com">&lt;smostafa@google.com&gt;</a>

Thanks,
Mostafa
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thanks for your review.</p>
    <p>Tao</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------S0LAryhZODTeHls3SfyW1nz5--


