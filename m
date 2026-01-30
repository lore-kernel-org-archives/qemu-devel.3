Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAE2E6BF2F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 18:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlsv0-0006h5-5z; Fri, 30 Jan 2026 13:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlsuu-0006c3-3T
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 13:08:25 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlsur-00007f-LK
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 13:08:23 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d2670932so2292056f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769796499; x=1770401299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mg1hGQ7+HgHn/oci+wK8VK17jaedyhSuhr2E5gD1OGE=;
 b=zT8Ckhcklg5hOBkb5wUogDfbNZ9aU9ruouD9w5dreSuC1yJJM+9hrLLTxs0kjYiP24
 Bgw7nCr6i6WA+Cr1YTj1QYo2h3eXlR2GVxPZ5fRnd0bVn2lFVSwyi2h1v/0AhufQjmVb
 9PaVuNCBjHhay7Jytsu55Klw4Hhbc63VXfDg6KYzC/jwH3LJYqzO/Sr8KMF3U0bf3Ifw
 JRRq+b/cZZjpN9bY1usBUZY7YALyBgA07iGpjhNXpTgj0YIApESTdbWi1459N10M9+ER
 7LxTWECqoo9WfdRfe8okmPrEwHdT1lHMICTyXgZHK1n2HGXENTk6HMOqv2/LHbGSxJkz
 s2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769796499; x=1770401299;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mg1hGQ7+HgHn/oci+wK8VK17jaedyhSuhr2E5gD1OGE=;
 b=Li7IV1KoaDDU08M2fdQsggksRKLPJ/3jdBKZQlTH721En7xQH3j21H/Th9fIYGR80r
 O5ntI9ONuwb+8YJ/cyjl3R1+A5JGs+Z2UZQE41cSuk3cCI+OfoGK7DtI7Wb+AuqIIxk+
 INXqwKpiLr7PTchoqUyYPTthtsYQVVw2IU6SpW1QPOWu5iQm9G/GUtZOIinS2z6nuLk5
 o4uibwiagjnWkS4GiHHJrLLr2gQgncSt4zMj+oYqA4/gOh2zspGgO6qMydDHWUKvs6Yb
 3OE5X5pIKq+NKWRtAGme1ljOkP0MQYInFMD8y17ef/+Unn/6Svc9++UjcbnL0CKAq+MD
 aTkA==
X-Gm-Message-State: AOJu0YxDmHPX4M+GV4em5rvD22yZhWgoypuRVH+4NuPBRw7dmFaJjd/h
 8jnl+KdnRiPkcaOqZFk0e6zfa8EAmG9jmlI6jGs2KaE5iuQBky3scCCj28V3LDKpVFBKOxRLrN/
 HiwriWck=
X-Gm-Gg: AZuq6aIJscu1/BiZn93aELFpZ93Y1AnOfOCEQV4RZJ53z26DR9W551L5a3adijS/w9j
 HTwy/lokH4vHIHLQFYxDVlcdPO+kkSuS1dl6KHwNY+WW+KxkfIt1dLBEPHzO/z4eXkj0w3GtHCp
 A76br7eTJXo2FJPe3wslJSjQ2yGzL0V+aNxzbCeeyimDmod+7AB37OFthKgxtbLku/z9nnG8k+1
 MkY3qv2qON/+G/UIimwEwaIptPQaPoYZ8/ZLbyg2ZZiIgO0LXe97JIh8rzMaDvC5a7y5itorpwN
 UTCpZGzP679FZ8nMzuFGYLPaGNkG3/CYsO8ZNoc0J12GMgIrkht1D5gW/hzZ2vOzKJvinuIRFtJ
 mefbQ/vwZ7OmYWh5BwYpU4J3YaVEQ5l3VjrBY0BCmzZbH218nS9JbZMJQKPNtVbtAFjGYyHiyc4
 +b57hprkNedGwCofONc0u9QBppM7dbf/0J5BUciNdnnBAwXVJ3miuSjd5o7YkKa3uu
X-Received: by 2002:a05:6000:4301:b0:435:8dd5:ad4c with SMTP id
 ffacd0b85a97d-435f3a6ba9bmr5233814f8f.6.1769796499088; 
 Fri, 30 Jan 2026 10:08:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm26182327f8f.13.2026.01.30.10.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 10:08:18 -0800 (PST)
Message-ID: <6101c39a-b837-461c-a6a6-aacc515e8ee8@linaro.org>
Date: Fri, 30 Jan 2026 19:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bulk: Stop forward-declaring enum typedefs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Will Hollins <whollins@google.com>, jpcottin@google.com, jansene@google.com
References: <20260130170417.43356-1-philmd@linaro.org>
 <20260130170417.43356-2-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260130170417.43356-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 30/1/26 18:04, Philippe Mathieu-Daudé wrote:
> The C99 standard chapter §6.7.2.2 point 4 mentions:
> 
>    Each enumerated type shall be compatible with char, a signed
>    integer type, or an unsigned integer type. The choice of type
>    is implementation-defined, but shall be capable of representing
>    the values of all the members of the enumeration.
> 
> Align with that recommendation by defining the typedef
> along with the enum.
> 
> For information, building with -Werror=pedantic was reporting:
> 
>    In file included from ../../ui/kbd-state.c:10:
>    include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 'enum' types [-Werror,-Wpedantic]
>       12 | typedef enum QKbdModifier QKbdModifier;
>          |              ^
>    ...
> 
> Reported-by: Roman Kiryanov <rkir@google.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/riscv-iommu-bits.h          |  4 ++--
>   hw/riscv/riscv-iommu.h               |  2 --
>   include/hw/misc/auxbus.h             | 11 ++++-------
>   include/hw/pci/pci_device.h          |  5 ++---
>   include/hw/ssi/ssi.h                 |  6 ++----
>   include/hw/xen/interface/io/xenbus.h |  5 ++---
>   include/io/channel.h                 | 11 ++++-------
>   include/system/replay.h              | 10 ++++------
>   include/ui/clipboard.h               | 15 ++++++---------
>   include/ui/kbd-state.h               |  6 ++----
>   pc-bios/s390-ccw/virtio.h            |  5 ++---
>   tests/qtest/libqos/qgraph_internal.h | 10 ++++------
>   hw/core/loader.c                     |  5 ++---
>   hw/display/xlnx_dp.c                 | 11 ++++-------
>   hw/dma/xlnx_dpdma.c                  | 10 ++++------
>   qapi/opts-visitor.c                  |  7 ++-----
>   qapi/string-output-visitor.c         |  6 ++----
>   tests/unit/check-qom-proplist.c      |  6 ++----
>   18 files changed, 50 insertions(+), 85 deletions(-)


> diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
> index 62a96ce9ff5..84b7d6c54a4 100644
> --- a/include/ui/clipboard.h
> +++ b/include/ui/clipboard.h
> @@ -20,9 +20,6 @@
>    * is supported for now.
>    */
>   
> -typedef enum QemuClipboardType QemuClipboardType;
> -typedef enum QemuClipboardNotifyType QemuClipboardNotifyType;
> -typedef enum QemuClipboardSelection QemuClipboardSelection;
>   typedef struct QemuClipboardPeer QemuClipboardPeer;
>   typedef struct QemuClipboardNotify QemuClipboardNotify;
>   typedef struct QemuClipboardInfo QemuClipboardInfo;
> @@ -36,10 +33,10 @@ extern const VMStateDescription vmstate_cbinfo;
>    * @QEMU_CLIPBOARD_TYPE_TEXT: text/plain; charset=utf-8
>    * @QEMU_CLIPBOARD_TYPE__COUNT: type count.
>    */
> -enum QemuClipboardType {
> +typedef enum QemuClipboardType {
>       QEMU_CLIPBOARD_TYPE_TEXT,
>       QEMU_CLIPBOARD_TYPE__COUNT,
> -};
> +} QemuClipboardType;
>   
>   /* same as VD_AGENT_CLIPBOARD_SELECTION_* */
>   /**
> @@ -50,12 +47,12 @@ enum QemuClipboardType {
>    * @QEMU_CLIPBOARD_SELECTION_SECONDARY: secondary selection (dunno).
>    * @QEMU_CLIPBOARD_SELECTION__COUNT: selection count.
>    */
> -enum QemuClipboardSelection {
> +typedef enum QemuClipboardSelection {
>       QEMU_CLIPBOARD_SELECTION_CLIPBOARD,
>       QEMU_CLIPBOARD_SELECTION_PRIMARY,
>       QEMU_CLIPBOARD_SELECTION_SECONDARY,
>       QEMU_CLIPBOARD_SELECTION__COUNT,
> -};
> +} QemuClipboardSelection;
>   
>   /**
>    * struct QemuClipboardPeer
> @@ -81,10 +78,10 @@ struct QemuClipboardPeer {
>    *
>    * Clipboard notify type.
>    */
> -enum QemuClipboardNotifyType {
> +typedef enum QemuClipboardNotifyType {
>       QEMU_CLIPBOARD_UPDATE_INFO,
>       QEMU_CLIPBOARD_RESET_SERIAL,
> -};
> +} QemuClipboardSelection;

Oops, squashing this:

-- >8 --
diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 84b7d6c54a4..2704434ded9 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -81,7 +81,7 @@ struct QemuClipboardPeer {
  typedef enum QemuClipboardNotifyType {
      QEMU_CLIPBOARD_UPDATE_INFO,
      QEMU_CLIPBOARD_RESET_SERIAL,
-} QemuClipboardSelection;
+} QemuClipboardNotifyType;

  /**
   * struct QemuClipboardNotify
---


