Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3547AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wja69-0008JB-Eh; Tue, 14 Jul 2026 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wja66-0008Ih-O7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:10:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wja64-0006dF-8w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:10:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SPLm3625114
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PXlh57RUs+9
 itnLzskqOqn0WAznohwUuKhu3736VQRY=; b=p5NMKpvDjYK03J8CTwKb1otsuCm
 l6nMQBw2eoXo/KddBdYtipqaunV2o24NYyG9yWYRZ5iY2XFBHBlXacctyuAutCU2
 1XXZ0xRST3VnnYVjSfTPsiMe1/QCrTK55WNcQT0l6KesodK5YKKf5GDZwPH1J5tH
 U/Xz77wPSqWSXHzL2PfR4LtGKKVUUu0yLlATObc5vT4LspUBABKmgl3dR9ekA5qw
 SmWVZRKGc8RzlGycaBzAs0oC/2WjyGvWSZIgEnX40T6DCMYYm1CzD1frutcknAcO
 Vcx5e7YKwqGXCbhAMjJwThyA+EQf61ADN8ZFDhDW0Dz4xHqLaln74Gpzqmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa946x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:10:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de0739ab6so2396472a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784023837; x=1784628637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PXlh57RUs+9itnLzskqOqn0WAznohwUuKhu3736VQRY=;
 b=NCMSJIpf/TeiAowkkjJDPL2/dCFih22E8vnJubscoOzrQeMIWsHodR1VOwAlNVCBf8
 fE5UzEQksEvJP/B+xoUe06j+pwPPtRmBaOcvcJOisaRrgsx6ZTyS7OuJtXjjqc0aXLwZ
 a0feavOWjTOMJCkXhI3cfrGG0nhbhRPrcT+DK/h0mcHk8BjHANaVZByC+EYYLHNZW+Ba
 xGmSMS+t1JCK0BSye3i165rRGXfyK5U7H24oz+lQ6FcsL7KX3EN0MUCYkhTx/2xz6eqy
 07soBERoAhdFaFH0ej7Bn6I5nL00pijNEdWDeFsR+kULZc2c9FQrxafAFwDZwibbVmkI
 8ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023837; x=1784628637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PXlh57RUs+9itnLzskqOqn0WAznohwUuKhu3736VQRY=;
 b=Xda5I5p/okrZ8WOH4sboSb8LrWCBwy1vSsk7ZMv6be2N8rMo28Gf4eqAh/ml8Ggvrq
 6pMLzXRTN3ESYqs9Hb/Ndhi3XKLhkjramLta+GKyOyVDhqhpost6sY5CwJvtOh+HZZ0G
 MQH+jruXNWYcP48M7fEfITtrrgOda0swzm4+JODepLS7aDs7lhZuwo3ZUXvSHsrxGFus
 EwX2Uvv+M+QT+kEwLq16J2C/bjtQoVpdSgGHuIsPRUd6wLpcHe0lsoz34AAwjcwKI9jH
 s5T9CUC/60OWbQ9dPmnoF1NRfGV3Nw3aoAZMLTY9rgq8SITd11CrUcZcF/GeivF/H5Ky
 Mn0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RodCd1IGUGkQWXUrVKy5Sw32wd1iVfR7Y3n5nFnBkAJZuVXHQTmyMZobUmP/BJy/NBroVZS6BuijVD0@nongnu.org
X-Gm-Message-State: AOJu0YwucyBXYB73QWP7QO5DxIa2ZOLBEc0v2x/q0UkM+baEQaN+N32x
 DalqXUXDF3Gh4fXAOt8Bbugb64En5tC1RebltKVXva6LZI0WLRIq0IbXfqSZb+BtXzkN+pFVWGy
 9FZY/HaYyWHH7fmuRPCP6YPFLR5edhKAXHebNI0xLyGyketxjWdbaZ5mPIQ==
X-Gm-Gg: AfdE7cnRxhQrWBxBHbsO/iee46nLAz/Jg3ZrWtSvrAhJmy3s+2y6L1R7g0SZwtskJ+2
 8xHLiS7r5a5xHXLUzYyiqb0BQpi3289cYn6LTbmKzuUynRtqlvtjg57DKvVtFKwNCBNFSicyxGc
 fm4vEGYdj7Ts828XlkGm5sakU+WyuZHcj3iiO72iSMHRq1cX9ddDki26pmUwFyYWv7+SaanRs6m
 A7w1+9UXk8zhEb7MMyz8dqSiWlQoVWjyce5GDd3Vt66OWf4la8ACbNFPS1Fxf5CIrA3TTgUxXrw
 oxLmpHYVdYnBjffRElJykTlEQJIEY4X81clcBpNtBh1vFIHVV6PkgZZTiBV1Q9BeRfiTletpbKi
 FPasxvKuK35HuIlW8ETFAuaus3EXwceVd0NQdvniMxA0ktPE8aeoQQdB543abpbitAQ1RCmZgwA
 ==
X-Received: by 2002:a05:6a21:6e0c:b0:38d:fad1:cf2a with SMTP id
 adf61e73a8af0-3c11062f6f4mr13996010637.13.1784023837266; 
 Tue, 14 Jul 2026 03:10:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e0c:b0:38d:fad1:cf2a with SMTP id
 adf61e73a8af0-3c11062f6f4mr13995986637.13.1784023836825; 
 Tue, 14 Jul 2026 03:10:36 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm86496924c88.11.2026.07.14.03.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:10:36 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, alex.bennee@linaro.org
Subject: Re: [PATCH 09/14] target/hexagon: add main arch-specific semihosting
 operations
Date: Tue, 14 Jul 2026 03:10:34 -0700
Message-Id: <20260714101034.606972-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <16868af0-8114-4f0f-81b8-05d6e6637e8f@oss.qualcomm.com>
References: <16868af0-8114-4f0f-81b8-05d6e6637e8f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX/lz+yTT45OtE
 YKKwTX8DnPDTp//+qfmxeIWk0emuvNsbhuQ9LdLbTqeG9Tc345eXLAhVKkqXJqbybzN/2PFf5WZ
 yZsO7UZW08NdtyyKJ7K5uw3rEOrnYOY=
X-Proofpoint-GUID: XGNytphyBEqbBBLBM4ts53kFcr0ptb87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX4pA7X3DqTCvS
 0IV2x/xhXn02QNyPW2wm00wxy1q/TcgDeiE0ys3jIdw3qwRsWW1E8V2UyiucRIr83S3wVTE9XI3
 gVWljlyMdL4JhE+ZHPHExWtIjGmfwe2QKNuJYsMURfAfowyBqQf971DqKDVKGAWIJSpIoTBoKln
 /1bltIYSLg9cy2cwgTga5SMDOyCgQhjT2t3RL+pD4y/ZioZxUtNF9b3iWuPh2gxfwFvHnVTtJmx
 H/FCr9oCquoEymLpUDtt+lERPPYpFFxNswrR60Rt4mWZ5y6TJp0E5kZC4KJSEc00VgT5Y1ZJvGc
 y/WcVvdCJ9YgXnfu+YvKrM5Kzik36Z+e/+78ZbSAuUNLRa+iB6t887V4bbXSghoHv6nENmLLpGe
 LjrlP9jKxZCfdq9ysJTMdCaIURMcbqHt3JbWf/mqRsUYNgpJ/MaiLC8bXkx2SHSwaia+jFxqxHH
 QWG4aBN9yov7hc/KBeg==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a560b1e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=r0F0oZlOEFFKyAxe0ggA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: XGNytphyBEqbBBLBM4ts53kFcr0ptb87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140105
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Mon, 13 Jul 2026 15:20:29 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> > +        target_ulong physicalFilenameAddr;
> 
> style: physical_filename_addr;
> [...]
> > +        static const unsigned int mode_table[] = {
> [...]
> Better to extract this with a static const, and a useful name.
> angel_to_host_filemode_table.
> [...]
> >       /* convert ARM ANGEL filemode into host filemode */
> > +        if (filemode < 14) {
> 
> Also, compare to sizeof table introduced, or define a constant.
> ANGEL_FILEMODE_MAX = 13.
> [...]
> > +    /*
> > +     * Hexagon's SYS_ISTTY is a bit different than arm's: we do not return -1
> > +     * on error, neither errno. So we override with out own implementation.
> > +     */
> 
> s/out/our
> [...]
> > +        /*
> > +         * This must match the caller's definition, it would be in the
> > +         * caller's angel.h or equivalent header.
> > +         */
> 
> It would be great to move this definition out of this function also.

Thanks, Pierrick! I'll apply all comments.

