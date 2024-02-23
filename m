Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EC7C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZrF-0001AC-Pv; Fri, 23 Feb 2024 13:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZfh-0007az-FM
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:49:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZff-0005HQ-N8
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:49:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412988afac9so811895e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710554; x=1709315354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYMViQZxpZ/oKbU6saSaPZG3/uaTby0qs1bVK8UlTCE=;
 b=c0Hy3X1lrQ7QtHNoXPdJF1O8JX8oUrKm+V4lirK9rEeaiZMNyEPPvZyAl6Y3xaYKwY
 jEZaaibePqmOdQZlPFJgFbncdEZ0F/py3yN0vVU0Sf2JPlp0+K11hv0plXyyPfRSMF+F
 mHhdziA+b7SxKZ2+ghB4xm7HHsMmiFhcGarPoqaFWw0jRT9B7rpm97CLRwG4u/JgGC8W
 mbQml+dlojm7cohumC8XKvrQBiO9rcKAizJj5SR2Tmys+cEcktZPMYOb5ANhqFQKv9MU
 FoWJaW+mZxPsVe6IR6K1bu8Ioey/RR1xvrswfZ/KWTaJXyGSFW+mCAdQxDSf0Jt2Ym6I
 NwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710554; x=1709315354;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYMViQZxpZ/oKbU6saSaPZG3/uaTby0qs1bVK8UlTCE=;
 b=dw/ai4HnkfK0tsoFxlEycloWrRXJocCE6l1YtNwi1kw5W6cfQyKNTduJwqZMfooOuG
 kbwMMcJbDgwgxC4qPoPpyWMj3pt+REwUOJCtWjYjUD2TcH1xZ0PHIWuI78btyC+s0HpC
 ZfRKrpMaoUwiToH9ANIzjz8hTBC09ttspX56I1hglvdJqZrFCXWBGXe7xnuJ9cDyW0ir
 N1dfI0PIkVUyOn8EQ3Ir2yTgNg97zGJS8g9skfu8xN39NT7ZBExR8hD4UpAeM+HB2UJD
 GOtSs5Z1sOiMpngxi7aub0dGa7qpGtDTXcPOAQ0BTw9qJJUwc8bYkOMpap34seoKY0A8
 zIFw==
X-Gm-Message-State: AOJu0YzR8mha0G5k5C0oe396Z5F2XrLUQZPFo1lwE/8+7ub5Ip4/Z9E8
 JJDINUw8VaL/cdD6uYesD5Pbe1B0LyBFxGhG+8gX7HfDhRdMseWkNVALzCAuWqNj3DbwY1ZRJLc
 v
X-Google-Smtp-Source: AGHT+IH1NrjFGll7w3yAhhYPa+Vimff/lyIxU8ApKurGWlz/YUH5GLdxUatcr8YuYy1+0wUNiTJdfA==
X-Received: by 2002:adf:ee06:0:b0:33d:746b:f365 with SMTP id
 y6-20020adfee06000000b0033d746bf365mr285524wrn.52.1708710553767; 
 Fri, 23 Feb 2024 09:49:13 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 v9-20020a5d59c9000000b0033daaef7afcsm3054872wry.83.2024.02.23.09.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:49:13 -0800 (PST)
Message-ID: <c7a5d4a6-99e3-41ac-998c-5d7a320dfe99@linaro.org>
Date: Fri, 23 Feb 2024 18:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] qga/commands-win32: Do not set
 matrix_lookup_t/win_10_0_t arrays size
Content-Language: en-US
To: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20240222152835.72095-1-philmd@linaro.org>
 <20240222152835.72095-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240222152835.72095-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/2/24 16:28, Philippe Mathieu-Daudé wrote:
> ga_get_win_name() iterates over all elements in the arrays by
> checking the 'version' field is non-NULL. Since the arrays are
> guarded by a NULL terminating element, we don't need to specify
> their size:
> 
>    static char *ga_get_win_name(...)
>    {
>        ...
>        const ga_matrix_lookup_t *table = WIN_VERSION_MATRIX[tbl_idx];
>        const ga_win_10_0_t *win_10_0_table = ...
>        ...
>        while (table->version != NULL) {
>                      ^^^^^^^^^^^^^^^
>                while (win_10_0_table->version != NULL) {
>                                       ^^^^^^^^^^^^^^^
> 
> This will simplify maintenance when adding new entries to these
> arrays.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qga/commands-win32.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)


>   typedef struct _ga_win_10_0_t {
>       int first_build;
> -    const char *version;
> -    const char *version_id;
> +    char const *version;
> +    char const *version_id;

Oops, missed rebase.

>   } ga_win_10_0_t;

