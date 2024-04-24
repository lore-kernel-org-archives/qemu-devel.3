Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42B7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 04:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzUcL-0006As-8c; Wed, 24 Apr 2024 00:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rzUcJ-0006Ad-GT
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 00:52:23 -0400
Received: from mail1.sfc.wide.ad.jp ([203.178.142.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rzUcF-0005TX-NW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 00:52:23 -0400
Received: from [IPV6:2400:4051:3e03:2d00:d5f2:e450:fada:3425] (unknown
 [IPv6:2400:4051:3e03:2d00:d5f2:e450:fada:3425])
 (Authenticated sender: mii)
 by mail1.sfc.wide.ad.jp (Postfix) with ESMTPSA id EA38673C;
 Wed, 24 Apr 2024 13:52:07 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sfc.wide.ad.jp;
 s=mail1; t=1713934328;
 bh=znDvNagA8+nn0v0RovgRduv3KO9dlexSERNoOr+GHrE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QCIcsXGX7PUXfvUE3cU5BnYYM5oXX28PU+JP7F4Ha/Pb1RgjFQZ5ORYtpsv/vNCvW
 qCTKO39F4ZgqN5THOG11Yjchic0rUcKkm5Lc6JQ4OE032ZA0bPcHSXuyoa1+UKHoM2
 brVXsWNHRdIdVSVSMRuHxCix+eDBGDjLqLXBzxFYAdIpxRDcri5ff/dSJfWmjbG4l7
 7U184h8j1pu77kGI05/wzGVKsJNk9FmUtsveWyF/4nCTec2e6fyMOmGSPlPCjo1fO5
 NcWLl4Gx/UUVB/WfHAdDYKdvNsYkTO+mBtVQLLv9mV5rEe32MWljfuPKixwBJENZRL
 BAIJSIPPXMS0w==
Content-Type: multipart/alternative;
 boundary="------------jUjf1G0cWaQ8Or9sfbaCxbNI"
Message-ID: <9fa52b09-c0ad-4ff4-bd62-cd7b654bd65e@sfc.wide.ad.jp>
Date: Wed, 24 Apr 2024 13:52:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
To: Yong Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
 <20240423091306.754432-2-mii@sfc.wide.ad.jp> <Zie5Fr3m9BquVpp3@x1n>
 <CAK9dgmaOOgQ3i2Er5GWz0i0917puSj_4Wt+1KZdJyV2KoazyMw@mail.gmail.com>
Content-Language: en-US
From: mii <mii@sfc.wide.ad.jp>
In-Reply-To: <CAK9dgmaOOgQ3i2Er5GWz0i0917puSj_4Wt+1KZdJyV2KoazyMw@mail.gmail.com>
Received-SPF: pass client-ip=203.178.142.133; envelope-from=mii@sfc.wide.ad.jp;
 helo=mail1.sfc.wide.ad.jp
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------jUjf1G0cWaQ8Or9sfbaCxbNI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/04/24 10:28, Yong Huang wrote:
>
>
> On Tue, Apr 23, 2024 at 9:35 PM Peter Xu <peterx@redhat.com> wrote:
>
>     On Tue, Apr 23, 2024 at 09:13:08AM +0000, Masato Imai wrote:
>     > When the KVM acceleration parameter is not set, executing
>     calc_dirty_rate
>     > with the -r or -b option results in a segmentation fault due to
>     accessing
>     > a null kvm_state pointer in the kvm_dirty_ring_enabled function.
>     > This commit adds a check for kvm_enabled to prevent segmentation
>     faults.
>     >
>     > Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
>     > ---
>     >  migration/dirtyrate.c | 7 +++++++
>     >  1 file changed, 7 insertions(+)
>     >
>     > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>     > index 1d2e85746f..2a7df52519 100644
>     > --- a/migration/dirtyrate.c
>     > +++ b/migration/dirtyrate.c
>     > @@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>     >       * dirty ring mode only works when kvm dirty ring is enabled.
>     >       * on the contrary, dirty bitmap mode is not.
>     >       */
>     > +    if (!kvm_enabled() &&
>     > +        (mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||
>     > +         mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {
>     > +        error_setg(errp, "mode %s requires kvm to be enabled.",
>     > +  DirtyRateMeasureMode_str(mode));
>     > +        return;
>     > +    }
>
>     Logically dirty bitmap should work with tcg.  So the other option
>     is to let
>     kvm_dirty_ring_enabled() check kvm_state too and return false if
>     kvm_state==NULL?
>
>
> Agree, better solution
>
>
>     >      if (((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
>     >          !kvm_dirty_ring_enabled()) ||
>     >          ((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&
>     > --
>     > 2.34.1
>     >
>
>     -- 
>     Peter Xu
>
>
> Thanks,
> Yong
>
>
> -- 
> Best regards

Thank you for the review. I agree with that solution.

Update will be like:

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 931f74256e..0f8499365d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2312,6 +2312,9 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)

  bool kvm_dirty_ring_enabled(void)
  {
+    if (kvm_state == NULL) {
+        return false;
+    }
      return kvm_state->kvm_dirty_ring_size ? true : false;
  }

--------------jUjf1G0cWaQ8Or9sfbaCxbNI
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
    <div class="moz-cite-prefix">On 2024/04/24 10:28, Yong Huang wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAK9dgmaOOgQ3i2Er5GWz0i0917puSj_4Wt+1KZdJyV2KoazyMw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default"
            style="font-family:&quot;comic sans ms&quot;,sans-serif"><br>
          </div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, Apr 23, 2024 at
            9:35 PM Peter Xu &lt;<a href="mailto:peterx@redhat.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">peterx@redhat.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On
            Tue, Apr 23, 2024 at 09:13:08AM +0000, Masato Imai wrote:<br>
            &gt; When the KVM acceleration parameter is not set,
            executing calc_dirty_rate<br>
            &gt; with the -r or -b option results in a segmentation
            fault due to accessing<br>
            &gt; a null kvm_state pointer in the kvm_dirty_ring_enabled
            function.<br>
            &gt; This commit adds a check for kvm_enabled to prevent
            segmentation faults.<br>
            &gt; <br>
            &gt; Signed-off-by: Masato Imai &lt;<a
              href="mailto:mii@sfc.wide.ad.jp" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">mii@sfc.wide.ad.jp</a>&gt;<br>
            &gt; ---<br>
            &gt;  migration/dirtyrate.c | 7 +++++++<br>
            &gt;  1 file changed, 7 insertions(+)<br>
            &gt; <br>
            &gt; diff --git a/migration/dirtyrate.c
            b/migration/dirtyrate.c<br>
            &gt; index 1d2e85746f..2a7df52519 100644<br>
            &gt; --- a/migration/dirtyrate.c<br>
            &gt; +++ b/migration/dirtyrate.c<br>
            &gt; @@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t
            calc_time,<br>
            &gt;       * dirty ring mode only works when kvm dirty ring
            is enabled.<br>
            &gt;       * on the contrary, dirty bitmap mode is not.<br>
            &gt;       */<br>
            &gt; +    if (!kvm_enabled() &amp;&amp;<br>
            &gt; +        (mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||<br>
            &gt; +         mode ==
            DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {<br>
            &gt; +        error_setg(errp, "mode %s requires kvm to be
            enabled.",<br>
            &gt; +                       
             DirtyRateMeasureMode_str(mode));<br>
            &gt; +        return;<br>
            &gt; +    }<br>
            <br>
            Logically dirty bitmap should work with tcg.  So the other
            option is to let<br>
            kvm_dirty_ring_enabled() check kvm_state too and return
            false if<br>
            kvm_state==NULL?<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default"
              style="font-family:&quot;comic sans ms&quot;,sans-serif">Agree,
              better solution</div>
          </div>
          <div><br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
            <br>
            &gt;      if (((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING)
            &amp;&amp;<br>
            &gt;          !kvm_dirty_ring_enabled()) ||<br>
            &gt;          ((mode ==
            DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &amp;&amp;<br>
            &gt; -- <br>
            &gt; 2.34.1<br>
            &gt; <br>
            <br>
            -- <br>
            Peter Xu<br>
            <br>
          </blockquote>
        </div>
        <div><br>
        </div>
        <div class="gmail_default"
          style="font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div>
        <div class="gmail_default"
          style="font-family:&quot;comic sans ms&quot;,sans-serif">Yong</div>
        <br clear="all">
        <div><br>
        </div>
        <span class="gmail_signature_prefix">-- </span><br>
        <div dir="ltr" class="gmail_signature">
          <div dir="ltr"><font face="comic sans ms, sans-serif">Best
              regards</font></div>
        </div>
      </div>
    </blockquote>
    <p><font face="comic sans ms, sans-serif">Thank you for the review.
        I agree with that solution.</font></p>
    <p><font face="comic sans ms, sans-serif">Update will be like:</font></p>
    <p><font face="comic sans ms, sans-serif">diff --git
        a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c<br>
        index 931f74256e..0f8499365d 100644<br>
        --- a/accel/kvm/kvm-all.c<br>
        +++ b/accel/kvm/kvm-all.c<br>
        @@ -2312,6 +2312,9 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)<br>
        <br>
         bool kvm_dirty_ring_enabled(void)<br>
         {<br>
        +    if (kvm_state == NULL) {<br>
        +        return false;<br>
        +    }<br>
             return kvm_state-&gt;kvm_dirty_ring_size ? true : false;<br>
         }<br>
      </font></p>
  </body>
</html>

--------------jUjf1G0cWaQ8Or9sfbaCxbNI--

