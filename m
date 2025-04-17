Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E848C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T7R-000426-HA; Thu, 17 Apr 2025 13:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T7A-0003pd-At
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:33:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T77-0001fX-U8
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:33:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224341bbc1dso12777505ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911204; x=1745516004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vhTtryGap1K2o5wTnxygMkEHjmeO5iibyeH1cqudL4=;
 b=y2NUYrhJwVmSCUKFJjyi0X5sR5EP5h6OPX44oRAHsp2mcuDRAVPlLWppCkEOxR4QwQ
 korqbkeAxO+8VY9B+UQVvguS5/GtjVBPKFDqWSOAcNET7ARsmHBP/xagUYFXWqbxtTe1
 QxZMVVEx0YoE8nlsm2wcJ9byEkJz5psxYfnUcLT6gGLoZr1i07Ywh/NWrzjX/hGQczuA
 bqk7sqfZZfsB75vkmXPeCX/Rgrke1YR6OOFKhBdnfEjDpZmtze/ITq6GvFGH3syPO72y
 aEaMcrKjUgeICYVyf2hWZKmZ70oX/R1QACtafEt6XACNH/TZuFpvR0rVP4nB/hd6INO/
 idWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911204; x=1745516004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vhTtryGap1K2o5wTnxygMkEHjmeO5iibyeH1cqudL4=;
 b=SgFp6A+fx4cto7NqQjUTQEjlu1pGexUdnruIdvJHsmafqfPlGTLzaB/H9Tqe/Dh9yE
 81XVkgw1tvoYYPeq43EQFgZw7TaxtItVtcuyo4Xz1o2ItadCg/IigZVNORo3eByio1jE
 HHZfb9hPuTbTk8xYiaiW8zjNnHcK0Pg3kPZxV/GvZhAQP1sSJW3viHWpZrQHz/ZeJdNo
 dZLpjqsxZwyuM5mfPeoDNuKO7GRrzwh/AQ4WV9b0ZsflvhmzVXOyepMOx1VcKGgStXK2
 QSEMcmklLrPAkvouTrNS8DcB23nJukUz9I6ecfvvg62G1VruNdU/r2WKJVQ7hXjjASbR
 a+uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUSNuzHoM8XQ1Pko5NdgfbeaKIqERIu9iI2VTk68S/pZvR0spz83QKAVy8Do69BZC+/JW2uwmPUvme@nongnu.org
X-Gm-Message-State: AOJu0YxvvFRT+aW6fytH/p2ICXmU0dtl8y4NCklCUb2PefSXiIYOYLW4
 8uJZ9vIjuULGGJYUNSlJi1Ui3iXztqf5OX9yaU8Wr04o7bJU3k/lXFcROsXkCts=
X-Gm-Gg: ASbGnctgqJQNXybiGZUdzJHN1M+RqIomxBixGuO8YNSkGqujr72zcFY9+4Dy2ZEDftY
 nyCHsbcG4/I0P6IXiGo4vabZ20Rr9hn4DkuzAdc60Xy9kiXGfFcRR+ktalsCxo5HHelUc5a145g
 f8BN2j1NhOsOz6LnTiyhK8jUTsb78r+JXAXGL5EsHMfTJxcCnaWuodx01tI6ZrXJZnRiYoO7Ym5
 pDT9HGNf1dVrzXRQeT3yDZQsAJEREcWcBLfVGA0fuLLv078Pp+yWMco+bgL4U12QkvIAQv+DqOG
 Ei9GUMNWXpuZRztbBs2kuyXlP+vCuMD5deUvVypxQk8q6HUBbuKyQaoC5JxLDAg=
X-Google-Smtp-Source: AGHT+IErzYcq1H20P6yOvoE6LLyZ9yoWqY3pshdd4b5VDmRnHt4/raM11+ONVOqCV9Kychsng2eX5Q==
X-Received: by 2002:a17:902:cec1:b0:224:1c1:4aba with SMTP id
 d9443c01a7336-22c35985601mr86086165ad.50.1744911204405; 
 Thu, 17 Apr 2025 10:33:24 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdb21asm2848835ad.5.2025.04.17.10.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:33:23 -0700 (PDT)
Message-ID: <045c7cc0-f67d-4511-a695-95bee96de087@linaro.org>
Date: Thu, 17 Apr 2025 14:33:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 06/13] test/acpi: allow DSDT table changes for
 microvm
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204204.2966-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204204.2966-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
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

Annie,

On 4/11/25 17:42, Annie Li wrote:
> list changed files in tests/qtest/bios-tables-test-allowed-diff.h

nit: List


> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..bb028db137 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,6 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/microvm/DSDT",
> +"tests/data/acpi/x86/microvm/DSDT.ioapic2",
> +"tests/data/acpi/x86/microvm/DSDT.pcie",
> +"tests/data/acpi/x86/microvm/DSDT.rtc",
> +"tests/data/acpi/x86/microvm/DSDT.usb",

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

