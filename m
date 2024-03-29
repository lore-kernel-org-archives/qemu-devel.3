Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157E9CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 13:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqC2P-0000hy-PP; Fri, 29 Mar 2024 09:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqC2L-0000hj-1X
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 09:12:49 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqC2J-0006aE-9Q
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 09:12:48 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a46cd9e7fcaso253608766b.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711717965; x=1712322765; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+/cYcyu/hx+LGwqRWJIb7grlJjyQbbHhC+97IBoxhQ=;
 b=ifF6Z/wTg/tZSbt3E7uyDdBV+XslBshsA5VaW9Aw1ZysqhpqhCvAUhxArQc+xqOWvn
 T5jGp388e4RqgN9abYuHPOLEtymZWwO+jIWAfdmo7YvuaSUiufBeNx/4vWhKV9q8kFgt
 xsinG9tu2yJB1wfnXQqk3fPs0EUdWJZFItvYfeb8d/g+6USh18WwZhFZb5V1PBdGOpbZ
 uhiAfoXdaU4Vbv4Lx5TmUT/+dfgvKtkWKoRT0ppicWrjG/fULUG8w1ooqNhlQYtQWea/
 pcYnsKbCu6hqslWhN/qGJ1Dy7Hj4LElOyvuSweHAmEoizxZ9FXtGvNMP9B3wv3X4qc2u
 q3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711717965; x=1712322765;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K+/cYcyu/hx+LGwqRWJIb7grlJjyQbbHhC+97IBoxhQ=;
 b=T2Ux6k6OhKM7ocI0Yn9c0JfqJYS4XobAGuzWICHRew0clsXHgwMffdjk/VVhLxAog5
 Qess0XSkOhb1u5ycquBTUo1gGmY4AqG/CPTA6pLIxcQIRnj1kqli9mdrAcwUJKPguVrO
 D2szG52nq4uaUWR4kBFPECY8FofVQ+Sx5sFPFaH+SwuKSRM3U6O5rGXK48aWytpstwGi
 Rj0opfmkQ4Kf7f1kgg7iZC5qyPiixHDZLvSyJ/2SOC0N6qLLeODFztAMiDWFsoAEm+wG
 ItIRpa9eXCWHwAgi2KF+VXLKSHMdCy5HvmDPTCOi7++O7EbFJu+A8k1MjMzIkMHnXhs8
 PCyg==
X-Gm-Message-State: AOJu0YxJuZ+mY77/TjTNGyknpGEpJKCP7H9xv5c426kV3m2eS5aJRmMq
 KkDL0srjtPyLzPNrUkdLC31g44zHbCF7X7mJCJAzX3UnJ5xuvxGPekIbSMn1t3jAICgPDchg5v9
 0
X-Google-Smtp-Source: AGHT+IFCeBrZ+4IfOfFy5PtSIqYXySfGGddBxJXidcnamnRDT6tWxDddmITGYLVwyB8QBSe6s0j8Aw==
X-Received: by 2002:a17:906:a88a:b0:a4e:1ff7:5c79 with SMTP id
 ha10-20020a170906a88a00b00a4e1ff75c79mr1820863ejb.14.1711717965204; 
 Fri, 29 Mar 2024 06:12:45 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 s12-20020a170906a18c00b00a4672fb2a03sm1939136ejy.10.2024.03.29.06.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 06:12:44 -0700 (PDT)
Message-ID: <a31e52d3-f65c-4283-b448-1dfabb11b776@linaro.org>
Date: Fri, 29 Mar 2024 14:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, afaerber@suse.de,
 ale@rev.ng, alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>,
 armbru@redhat.com, bbauman@redhat.com, bcain@quicinc.com,
 berrange@redhat.com, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, clg@kaod.org, cw@f00f.org,
 Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de,
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 konrad.wilk@oracle.com, Luc Michel <luc@lmichel.fr>,
 mburton@qti.qualcomm.com, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 eblot@rivosinc.com, max.chou@sifive.com
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: QEMU Community Call Agenda Items (April 2nd, 2024)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi,

The KVM/QEMU community call is at:

   https://meet.jit.si/kvmcallmeeting
   @
   2/4/2024 14:00 UTC

Are there any agenda items for the sync-up?

Alex maintains the invite on our Linaro project calendar here:

 
https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGc&tmsrc=c_k5p2lpgvbptdirku5si01blmnk%40group.calendar.google.com&scp=ALL

If you want to be added to the invite list let him know and you can get
spammed by your calendar app as well 😉

Regards,

Phil.

