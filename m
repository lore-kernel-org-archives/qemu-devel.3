Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B4CD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 18:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snMlu-0008Rp-U7; Sun, 08 Sep 2024 14:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1snMlt-0008Qx-He; Sun, 08 Sep 2024 14:36:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1snMlr-0002xO-Lo; Sun, 08 Sep 2024 14:36:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20573eb852aso30945515ad.1; 
 Sun, 08 Sep 2024 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725820581; x=1726425381; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=fTYiG37Se0sbkN/Q2JONvnr1L/pNa1lHcmOyWXcl2NQ=;
 b=dpH1KvdWvF33Kck3A+5DcEEqYfu3CalqzBxE+oSkkzEJWL6zlPiNBZOX584LjB0Qnl
 1Mpm6vSPv0NE6xNVq9jY6upzG7fgcCTsSidmeKggJVeOG8ehnHx6DQlz9foMLtmuzDai
 IGqIOfWtQsHfaG1G+43MGCoYVAals2WTCRESNUR8DGSu2dpzpVtLCsQkN7W8rdNFH7ZG
 SqFGnA2FpeXaMwL04zZWmseCS8yMsmKz717HP30+2LpJrRTHbT5zDVPJCrQQ6lXZY6v9
 lAi0ONZv9hRgcXroEBZTXZOuaAzIfNTCoQO9ffE+vEpUhE2eRaJxSf8fJwOSg686cYRo
 //TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725820581; x=1726425381;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTYiG37Se0sbkN/Q2JONvnr1L/pNa1lHcmOyWXcl2NQ=;
 b=qOThDgHLvI9/J3K/gX3Vzs/23bElkS8lXCoXF4OixisjhXb6aMdr1ZJaEo9uzsaoI8
 vWlYS95DcvSAP6n+ANfaH/iYNYFTsI7oCVSfnwS+oVtH8htya2B3w8FEYWYfXvV8v32a
 reIWummGeHI5DspA+8ESuDutknkZf1PsfVwM1rk/06NPXs1nLYe+Ewztkh8DM9cXa31d
 q4WLZLmVNwFFGjuDmSOrwOPiv8vAsdl+fWhiWjx9JDhRfe+Z54kCc7O7v2NU0l/+RNqh
 ImRWryjH6/uIQeu0iDeX1Vg0PBaSPkaOP5bYIh83LATJo6fKsZkaT6U1VnrLm+4rBIRa
 u5Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Uo1jLhG02G00iYJYg3g4jpxdLHciy46HyOnTV7kdoy17Ly1wOqGTqGuhX/9PRXFRk63E7lClIhm19g==@nongnu.org,
 AJvYcCVAxYt1X/182OulMDMzy+sZT2s5LOzEcZVP4u4XSZL4JfhIc/PQixPRb6K5jRSyda7b+AhBcG5tGA==@nongnu.org
X-Gm-Message-State: AOJu0Yz5rhUzJpeAqGhTqBvec6t/aIsinqLE33Umxn5okd6EKu83yidU
 B1+gX7GSb8eNhI5fd2GEQGtR3spMJA8n8U5+yQfgwksym+gZ7ts+
X-Google-Smtp-Source: AGHT+IGjvp4TWbtVScWyKwCXT8WsP39V98eVYOpzm6Odw1Aevl6SrZVma2G6plCNRzv/MDKkuuKDwQ==
X-Received: by 2002:a17:902:d488:b0:205:5d71:561e with SMTP id
 d9443c01a7336-206eeb8ca5amr124470175ad.26.1725820581050; 
 Sun, 08 Sep 2024 11:36:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e16fa5sm22261205ad.55.2024.09.08.11.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 11:36:19 -0700 (PDT)
Date: Sun, 8 Sep 2024 11:36:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: qemu emulation for USB ports of Allwinner H3
Message-ID: <85f61ad3-da14-43f7-983c-62053ce0cfa6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

the Allwinner H3 USB port qemu emulation creates separate USB ports
for its EHCI and OHCI controllers, resulting in a total of 8 USB ports.
From the orangepi-pc emulation:

# lsusb
Bus 005 Device 001: ID 1d6b:0002
Bus 003 Device 001: ID 1d6b:0002
Bus 001 Device 001: ID 1d6b:0002
Bus 008 Device 001: ID 1d6b:0002
Bus 006 Device 001: ID 1d6b:0001
Bus 004 Device 001: ID 1d6b:0001
Bus 002 Device 001: ID 1d6b:0002
Bus 009 Device 001: ID 1d6b:0001
Bus 007 Device 001: ID 1d6b:0001

The SoC supports EHCI companion interfaces, and my understanding is that
it only has four physical USB ports. Does the real hardware instantiate
separate EHCI and OHCI interfaces (for a total of 8 USB ports), or does it
use the companion functionality ?

If the real hardware only instantiates four USB ports (or, in other words,
if it utilizes EHCI companion functionality), would it make sense to
reflect that in qemu ?

Thanks,
Guenter

