Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2116AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seVVe-0001Yu-Ri; Thu, 15 Aug 2024 04:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVVZ-0001W5-Ep
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVVW-0001Mk-L8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723709210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t0j1PrwMwd2r9/bZ28wzYoxOwHXdsk+gBKjqqJdXh9o=;
 b=YDMKtK6N6uFy4pDQ8y+NI0yCmeQ3Xo4nfulirQstT7M1mxZfw+80YV4N5fui8ee72U2xBn
 V6h8IG+yr3+3OHuZgxVcoayw1W/A/rPzuFcKzJwbH59Ta0FvKOf0eNu/v/PMMw+TQHrv+9
 gMZTOMRtYWjBZasGeDwR8wF3/RdhjMM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-j1WUQdBHP0iQA0tVMsi_gw-1; Thu, 15 Aug 2024 04:06:48 -0400
X-MC-Unique: j1WUQdBHP0iQA0tVMsi_gw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7d6a72ad99so59405666b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 01:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723709207; x=1724314007;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0j1PrwMwd2r9/bZ28wzYoxOwHXdsk+gBKjqqJdXh9o=;
 b=Li/uME1IkEkePcc53gDsw49UARC4w/d3gAWc6fdaCoQCADHPOXHhqoWufl4iZVjB+E
 SZCV8sdQSy1l0qBK/JNCy/k3FSBkX02EGpyVxV4gubBf0e4lBK5FLAU5z1HnaoOULHCn
 5cOVS91Mw4Qg4Juo4NO3pSdHCki5EkJ08XuF8Cu2kx7exF2TcnGgMSnMAhM8TPKNAYPL
 u7j/xVjf7+VwY+AiicdrV0PJ/xwb4zhHtdV2qFayyAXMU9HJCIJNnoZ8dQHXGrtI2NOD
 gIYINc17Pf7U5yXw5iGTCfEDXGBXoVzjvD2JL9bSvF/Ru5Add924j8pOF8YvgDn7zQsK
 YXuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuA0aLERx2uTN5WRDSjM6wMhcDphww96AIuNEeTm+py+EX2R16oI97TRDtRVSHFIGAbJ9or8m+dsz+zJELtqBx+Q91D8A=
X-Gm-Message-State: AOJu0YxHYNSBxlMJNGGN8mlggm7jGNobrmBoNgmTUE6k8eMCuk9zmQxg
 gs7/QJ/xX/plkx1Gp657w7IqcOxXyLWKqMA34NiwDnw4KNhr9/W2kidNkqfoV0fChap5PRHdzdZ
 JRxdvvb6PkL0dfbLD19ny2T4NukJSn2rv2VHTXO9es0UNMSOhOATY
X-Received: by 2002:a17:907:e661:b0:a77:bfca:da53 with SMTP id
 a640c23a62f3a-a8366d5a3aemr366716066b.30.1723709206989; 
 Thu, 15 Aug 2024 01:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz6dB2Mm0vW1IJ6TkZH0s5ImckfPd3b/YaarhRqA7vj5GJ66BbWYcTenJdnNz1PZtFCohH9Q==
X-Received: by 2002:a17:907:e661:b0:a77:bfca:da53 with SMTP id
 a640c23a62f3a-a8366d5a3aemr366713666b.30.1723709206473; 
 Thu, 15 Aug 2024 01:06:46 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396afe2sm62826766b.195.2024.08.15.01.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 01:06:46 -0700 (PDT)
Message-ID: <e1fcdf3a-1f28-4e6f-95bc-19eebb6b6d0f@redhat.com>
Date: Thu, 15 Aug 2024 10:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] contrib/plugins/execlog: fix warning
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-2-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240814233645.944327-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/08/2024 01.36, Pierrick Bouvier wrote:
> Found on debian stable.
> 
> ../contrib/plugins/execlog.c: In function ‘vcpu_tb_trans’:
> ../contrib/plugins/execlog.c:236:22: error: declaration of ‘n’ shadows a previous local [-Werror=shadow=local]
>    236 |             for (int n = 0; n < all_reg_names->len; n++) {
>        |                      ^
> ../contrib/plugins/execlog.c:184:12: note: shadowed declaration is here
>    184 |     size_t n = qemu_plugin_tb_n_insns(tb);
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/execlog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index 1c1601cc0b4..d67d0107613 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -181,8 +181,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>       bool check_regs_this = rmatches;
>       bool check_regs_next = false;
>   
> -    size_t n = qemu_plugin_tb_n_insns(tb);
> -    for (size_t i = 0; i < n; i++) {
> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
> +    for (size_t i = 0; i < n_insns; i++) {
>           char *insn_disas;
>           uint64_t insn_vaddr;
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>



