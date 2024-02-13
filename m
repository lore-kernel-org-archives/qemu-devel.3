Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF91C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsgA-0004ko-W3; Tue, 13 Feb 2024 08:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rZsg7-0004kK-Af
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:18:27 -0500
Received: from smtpout37.security-mail.net ([85.31.212.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rZsg4-0000KH-Ec
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:18:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by fx301.security-mail.net (Postfix) with ESMTP id E69AE5A6B11
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 14:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1707830300;
 bh=wO3QmRWx/eg7Z0B/0cGK0pENvgRW6yUbY4yHW+gRDLY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NVznfXCLamWfYpSOt2LwIsVS5NEc+cBF1YY10pYdkxNQ2igzTLZ1to4W/frErPmIs
 OYhcpRPkP/76vfg8SOFREAEXDKPPtjxS2JIkLrMzVvbz39uUQkB2BgLUB3xIk7Nl/W
 TqkQ8cChXzPU6HShTf4u+a2mXdeZthLBR2hpB/tA=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id B63535A63AE; Tue, 13 Feb 2024 14:18:20 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01on0101.outbound.protection.outlook.com [104.47.24.101]) by
 fx301.security-mail.net (Postfix) with ESMTPS id 370175A5D60; Tue, 13 Feb
 2024 14:18:20 +0100 (CET)
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:8::13)
 by PR1P264MB3529.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 13:18:19 +0000
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c]) by PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c%6]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 13:18:19 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <7c2a.65cb6c1c.35b9c.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MueihLk0enRyoOcEDCT1DcPjC1gNQ8Vvo0ApsAdsMpsQMwF+Ni+KqQRlf5L2R3KLMQJkY4JG0DDRyNc1+Ys25PTxT9F+4wihnr/Asf/+vVwzbfdwhXmzSuPojzENJPKO+NQ+CsW1CD8DxiqQ68pyVfrRFha9xuYEx6EznMac3FINyGPgMYmPRlV8sXt0e0Ad0tGmcS1QWdXjr5TWcRNXP4YmbMLoNBKG4NJrTPjlFcul5D0XAg2AF8k7Ljgelhk8AnzmNOulOArWYb7JTYg9ri2JW6BI9vQQp9QBGsJjbMK/nQ/37VesbvNqpFQPx/bsnAN4936vqKnSL7o84tULhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnqKqnEHbdaryrRCDQWT45R8kItTkVud8UW4gGvjlYw=;
 b=Ymxj7H5F7EjedPtck2nLjni1RFFMveH6O6NY7Fa484XEUv/WaC9aqNiEwTftvHayA9Efn7QeYi/X1fiIGsziPsynbTSKZd+VyEfYe1W63ZzOgNRhTXbjn/jPqM61mD4VnGEwiZui+e/ejj7R1Wv6r1YI89v+R0gzm3RvnFahRv1nVfBlOIaYDHg1b8AUZ5DlpGXH9UrBlPI0Bxa6/X4DU8vjPmHkaR/5OVoBOsw9uTt8jYvifZTu6Aw8bu3ztDafZayHbKAfmRjAjWp8wGV51sWndHUn7nDSOX+fIquzdDLPGK2GzF7rOETH/z25TmQnojV5NlEvx8PxANRfXd1vMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnqKqnEHbdaryrRCDQWT45R8kItTkVud8UW4gGvjlYw=;
 b=PLf/hhyg4i0vDT6d4e2qBEO+ECWIIYIc5JvT5n87klbB3bGea6aXl6iSk9ZsvjplA7p1ex+PSB4O4qm/5t4gSt224USB9lZvOXcVNzcs3nUuxB09ee9yZk8lIZrh1y8Lwm5hX96rf8Qw8gJA8b1ZOUoiC375Ht59LjAF51QlK+JZk0MrE76MHOLG3gQ9FKdsmjWc9jw4y2Vpn5BaioEyzclRlH0eQKND3sxQzIK3pWQRyviLz1sEAScqQL3PmEzIyHxuvtrKultVj6L8VtFr9k48ulHayxmhT4UcBS2BT29b8opU0i9Lcw66sXnIqJ51NCT10hkXZax31vrAUmy+Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <371a569f-09fa-6f28-3b48-4365adb8fbf9@kalrayinc.com>
Date: Tue, 13 Feb 2024 14:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 04/12] hw/i386/q35: Realize LPC PCI function before
 accessing it
Content-Language: en-us
To: Philippe =?utf-8?b?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow
 <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Richard Henderson
 <richard.henderson@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>
References: <20240213130341.1793-1-philmd@linaro.org>
 <20240213130341.1793-5-philmd@linaro.org>
From: Damien Hedde <dhedde@kalrayinc.com>
In-Reply-To: <20240213130341.1793-5-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::12) To PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR2P264MB0861:EE_|PR1P264MB3529:EE_
X-MS-Office365-Filtering-Correlation-Id: e030095a-6acb-4bc4-81fb-08dc2c963eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6RZApwyhFoOCkdsU72y705yfvYacmaovhCZXRH2ZH/PK+ZgKBk9e+4FIj02H/SNstl9rVaoAEjplXziTh6p5rG8njfvfIyp2V9Wl99WJFjpZq78rZ9OZIPLTyOBxl37eWfxjYzzLELMQijAcQnVgQU2ezuo5g0382f0IHyj68n/1f9YOZl0aCiN5zrCBn4T0DHiOGZhx41ZvtSvXary7/vj2Bf8R8W0PeAbxtEbE/WmzeEcjHLzLxfHZsDXkYxTFmvX9+8kXAUo0qp6oDhMkO+4Fzvqa5GIXd5RnVSj7zrFiCAAei1uTRR3xxJrqDSxWtdVJzfceYsxEgajCIY1xPYp++rZbOYjkws59ZSLiJJe3LpRVgDt1frwN7ylDXFBA8ndatH4g0ahgZQO3OQk9xpme4g3nbfflG0U2/hobEhpEsXTd9EZsqeWfZ8twG/HuAGJ75WJ0ThdzobV3SBTtks3feETvWBVSNccbaZnRJAuz9s+aNX3FhBQV3xIO4uc3ADVmVlI+1MbAWf/xH3i+SbBbls7hTnZD30VwNG2H//4YWc7x0X3JEKaDuOBJV1t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39850400004)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(41300700001)(26005)(83380400001)(86362001)(6512007)(53546011)(6506007)(2616005)(31696002)(38100700002)(8936002)(4326008)(8676002)(36756003)(5660300002)(7416002)(478600001)(6486002)(66946007)(66556008)(316002)(54906003)(66476007)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h7mP1jTqTc7XzFEwKaXFjSUvvwYAtOk5v45x+nFBR6bkrWhad9meswJpusuQu2T8ToBchdFRFqOXDCvSxzylEsIo9+CDYS0Toek/e/RJGamJuHtFdhpyHvYjPwZC4wx/l8qX1WqhktubiR0XXSxsU2BuN/jT4chuQPWoJhzEVBxMFv9wPQczEQvDNOB69ZdjTzZGqB+JVqWylexnYYXiaRP8S92uVbC48t0DqZBkSJquW59ZhCxGprVrB8YMnxP1f+RATrWg5qU1581YtzO8MxDRQrpyzzbNrxCWJaZKa3xaMphIUxBUTXwCNIYkMQwclSHqripdWuW6THn5m8GTiCjSMoV+gxImSGI44tQNvmeM3iLoC2judp5gml7LOUnjoj5mEE109SekytqGuprEkPJzy+dsL/eKz7Lm+kHdGZXKcFmNfEmR6KcVDoje/MDDMP6eYRsGDg//VmuL7ydHsXfdS1Y5oXDQkHgibAYv+3Wm5NnWfbK/F/9+zGHiAjc916klX7q010CUqoYIdbB12+D8ojGx2ETg6LVg555Cpe+3Ebe8HHIBtNx7gnkjad5JSwDJGkCUch7qotTaMewgOSNGE3KIaMwCljDkiQpnZZdpwo4rbYzEKSsuqGHwGaTItaI+rdrX/s1gkRgBfsB5UOqUy4u9dsc+diGSNAyOBnEPut65DasurnHRjPdN7dzozPXUB3VsdntKNEevc8YxnI0NlKMLH08RnR5vfwxrGQJnjMdWCE0T1YKAZdwgo10sc/dtMHXvIA0GFbJpMfLR1/m8BCJdS5200l3ssQsdX5Z9C5Je0goWpvWNaURQzEn1ycBomYxVCHTd+OTASu7P1zaUm/zrcfpPmKQM3Moy3gPcU5FL2cgh2VjXBcOHqMrfMGjgcESwSCwBFtE2LNNhpevZSaLetTEne+527F0pdjVTEi3z06xXfnIjjzklGiQ9
 X8N9i8YwhOXiVe8jvxsKjkpZwlmHxWu820EJXg1oa4NgGq6XAsM4e9moG8BTztmSesARKClcF1pEcC8bjvAMhfaXRXA4bAsXbV06V0Kx4QOQ1zYW9+CfzOvwhdTCfGJhTrO0a3Z0Sxo1ReIyuwXwsWZst5of2hd3gi+AGdWo2saizZMB6c8GZiiZuRV4uGzIJjoVRaLIr3VRAJg5uyaJgNYP0GrxC2D57zVN4Felq4h+sQZNH/g12oMHM8FCdLcRSmdzbN9vaXmaoVDmvgKigzyaVB68wBpO6MkvmaED3E/jDAz/wyGWWVw2+2Mfl1ik0IiImpflCs63ijvghULRJ5s9sCtlHcwLM7/9iObCj2UGVWXEXQZkTKuQPIJW8W2y+GyVMW9vWthByBmWdU1I35izZ++ulv77qxsLe19PvZTLJxxrDIuqh+3PA5FfAuLvapBTssk1pvO+Je/uCyjVIGZ8X452ehAGiThZjgCBTPtF3hU9vBgZsKKYDWOlg7TdI/tGf95ZOQvimLhA3mfKQiAPh+6W5OC3cibwM1peUFoUFgjYRfonchCE7MwknupcA9JqAEvz+iSNO9htFNp5KfnESTznbU9Fx43n4ZuOo3ThWGJ0FDOX0vAzFMG6wS7d
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e030095a-6acb-4bc4-81fb-08dc2c963eec
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:18:19.3071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OwSPW1yALqPKc9Gkn2c3jHtPLlBJVp/+fglwFgIMCGkZPu6WFl6XNO4yr9VBnG6gBlvfpJ1Os5Gg5hxI9L2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3529
X-ALTERMIMEV2_out: done
Received-SPF: pass client-ip=85.31.212.37; envelope-from=dhedde@kalrayinc.com;
 helo=smtpout37.security-mail.net
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.447,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2/13/24 14:03, Philippe Mathieu-Daudé wrote:
> We should not wire IRQs on unrealized device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org> > ---
>   hw/i386/pc_q35.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 7ca3f465e0..b7c69d55d6 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -248,13 +248,13 @@ static void pc_q35_init(MachineState *machine)
>       /* create ISA bus */
>       lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
>                                   TYPE_ICH9_LPC_DEVICE);
> -    qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
> -                      x86_machine_is_smm_enabled(x86ms));
>       lpc_dev = DEVICE(lpc);
> +    qdev_prop_set_bit(lpc_dev, "smm-enabled",
> +                      x86_machine_is_smm_enabled(x86ms));
> +    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>       for (i = 0; i < IOAPIC_NUM_PINS; i++) {
>           qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
>       }
> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>   
>       rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
>   

Reviewed-by: Damien Hedde <dhedde@kalrayinc.com>





