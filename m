Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A431E88D74
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 07:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8vUI-0003l2-Ii; Sat, 04 Apr 2026 03:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w8vUG-0003ko-TN
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 03:32:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w8vUF-00036C-CU
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 03:32:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso836933b3a.2
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775287925; x=1775892725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cF7QQ9yULVdzcsT/6C9VQufE7qOqZLs7nYSNXpJUKGc=;
 b=Mc11hvXDz5gv2M46BTSK1d/RMIf3/lbl/R4SiKAquGB8rbUObxOxsFDamSFGEuqAuV
 PA8FiA9/rykTQ2zPSyskzT1FLksXNF90pRYRZE0fIQqxfGxO78TrsI8VaOVkWZbptrSo
 qak8tH68E+5CSShvl9TcNvbJON5DbfLbRMYBqXY/OppSJRpUO7fztTh1lLw4kJGG5BPY
 26W4vX3mlHBbhXVKDSAzlET174NFte1sQ9TRoLT5yqBKeQ6lLeeQxt68yxcKhvsJ/Ek2
 4h98XAGWhAmw5fw+rl5spIZnO32fOdx2C5D8TbOLuOvoPGjc9T20JenzVI2/rjCHufAt
 xE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775287925; x=1775892725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cF7QQ9yULVdzcsT/6C9VQufE7qOqZLs7nYSNXpJUKGc=;
 b=A8pkX92qhOVfk15xB2+RPJzUxc6DmC7J1VinrdS3+zsAoiAVoU4sBfuqrH06giF/dp
 V34l934jafaLx0PBhkctCADWhYo4jfn4HD5HqDY/TBOPL8uZ+IHim+Z4PhWD4MNfx5ep
 gMPO3yr0IUJZGLnOjaZluY5FyolA0ajNlAAlsNEHzIaACWtPOGnZI4ByuI03ZVM5/4rs
 q3OVVTuNZrJgD0F3FSG+4KnGLeOaWN+DleXV5DzrQo54AF83vWEDXq/GAZPfmBE51536
 lVw80Wpao3tbEyerfdmxso26oXLJiKs+X9/CLl6cm9rvk3+91pipqkPmn7KLOroXNbV4
 dThw==
X-Gm-Message-State: AOJu0YxemIH7fJFiij/OVMag2GbVH2MrN1fBehb1entI+tewFRgow6Qj
 yGQVK1fDwTlFvS0u48OOT574o1M5KXnPTA6iLyr7WIDNJjHksRK3YzWN
X-Gm-Gg: AeBDiesqOBdZb441qDj9yxMTzwmXeMRGK4WWGqcQoZTrzTrIsaUHePAJdNQa68prucO
 CRqX58R+cI+jbcHQlC5FZhMJ+Ut3be0xfR6M7N0GIBQjSfbNlpLZy2VCrYg9Jc5ahAMgeoVdzlG
 gCK2BFZgMQxL5lPGn9OWWx5qNhrI0FEZvMt//39r3NN+UeraF3BDeaTZmH/LWLUFcHKcchawBnW
 iHEsw3enTnK7Kbx6MPVH9FKGwYbJe4hWjixbU1XBHgPSKppSojTLqlDOz+55WChlMCsXTeC+Dpz
 wqyuYsRtmZveWVkZTNXomKDHF3OnHM/+LHlVmEEXXg8tb9DTeckqWyAIeW1A5WmJCNYW1FlX+je
 +nLiRhmcH06D9hZnjym4kWCqnbAYB2sfaEaotz5p+OcYjoyZqpq9PyMbbJeUBjX/3sjQAES0wvM
 dRg6rcgX8u08wy3fdz4J/dbIBApfRA70DYtLWSAjXHoRFytfcIcqm7eTWz43CaIrF3g+ajZL0Hy
 waZkA==
X-Received: by 2002:a05:6a00:1d9e:b0:82c:212a:906a with SMTP id
 d2e1a72fcca58-82d0db53f93mr5586345b3a.36.1775287925017; 
 Sat, 04 Apr 2026 00:32:05 -0700 (PDT)
Received: from ?IPV6:2406:3003:2007:2131:5869:dd01:3236:d43f?
 ([2406:3003:2007:2131:5869:dd01:3236:d43f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b261absm9227077b3a.7.2026.04.04.00.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 00:32:04 -0700 (PDT)
Message-ID: <bce0d2e8-c06d-4158-bee1-476293458f59@gmail.com>
Date: Sat, 4 Apr 2026 15:31:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/readline: Fix out-of-bounds access in
 readline_insert_char().
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260402105150.274595-1-phind.uet@gmail.com>
 <CAJ+F1C+JxRRmaD+GZ_=F=kh3sjjr_f+Us8LQoGVPSn5Ue_MzLg@mail.gmail.com>
Content-Language: en-US
From: Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <CAJ+F1C+JxRRmaD+GZ_=F=kh3sjjr_f+Us8LQoGVPSn5Ue_MzLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=phind.uet@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 4/4/2026 2:41 PM, Marc-André Lureau wrote:
> Why change rs->cmd_buf_index < READLINE_CMD_BUF_SIZE to
> rs->cmd_buf_index <= READLINE_CMD_BUF_SIZE ?
Hi,
my patch is actually change from
     if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)

to
     if (rs->cmd_buf_index <= rs->cmd_buf_size &&
             rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {

BR,
Phi

