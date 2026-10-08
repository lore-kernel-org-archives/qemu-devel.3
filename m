Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE14CA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEqYz-00013T-Om; Thu, 08 Oct 2026 12:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEqYi-0000pH-Ad
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:01:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEqYf-0003YV-Vj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:01:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVPR33121539
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 16:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RlUTbroe5EhMNOk/M2KxixZlfsLguukaisJJfZtPO1c=; b=HAUXh8Y4FYa72O+a
 V4Z+WsYPv65eHu+OMqUWnfzrOK+LT9Fb904JPzrGiykLXXnYH+acYTJyIYjw1t8k
 LhwtGY3mN6zHTDdZ2jaD3GUr7aIpS4tMa9g8L95iw7oA2ntvEGScR7A82N4/gkvm
 obJBTyIH5p2NAlQwKnOLfMtgdjEsjhiYi+nh30QR/ZZXfAeG1DdlPc66uLLchGSF
 yupgxQW4ssfh+jOMqR6ISXN6E+o9jByY8HrnW6vZLOrgFK5dREBs4Om3iuBXk+N3
 89um0Qiwrkrm8bja5VHLlhsgJ5nXBFEopfKwBDY7SbQssNuwCVjE4eGnrPsvOj3d
 0NSh8w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2urf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:01:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34ef0362d95so10667496eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791475283; x=1792080083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlUTbroe5EhMNOk/M2KxixZlfsLguukaisJJfZtPO1c=;
 b=BoaDO0Wh2quLYwouQGxKgfvaJRzF76HF/f5RvbCGYTuDEZhjNqTR0wqF9EvLhnNC9o
 Ez8kxqqMtKI39Sru0IJ6y1kgPhi2AWimEF4dR+VNa9tiTRCnk9JTtB10p3+d+zTetgYq
 JvSrugcqjQ1WgIA2h6rXPiiEAuFkE/2zFFWGm7Uy4KjS9Wy5WBacTZ3C7/q9SGesITo/
 gjQJSz4HaenWKTuedMMeW01HBLRNpkxW7t9N8aerFP5sKUBwFUjLpSAwHbvdEhUZGft6
 kcDfZZ1+801OXiX/vS8MbOux8RlQvkfVGCDw9rGkvM1aAwR+SRSkpdubuvyRHlb/4Uyv
 54yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475283; x=1792080083;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlUTbroe5EhMNOk/M2KxixZlfsLguukaisJJfZtPO1c=;
 b=CrvCnExXJDUrxIpPJg7nwKuhsAfJ/SBxgizktSCFPQ7xsjTzVb3tKifLr+F+Bpy8qt
 PEJaVu1OhZCa8Fy3ZiKb9yiVvkDBqBWWC3OIsnS+x63U0XBIBXBuCfTWBm/iiNUO0y+k
 wMiH49q/qkCoRLkYvv3Mur5ODUxQkI1bvVcyx7ZeuFrG4FCy0rpg9EtBVdy4Y5c7JydA
 6AGVAt4qgm2EC3SpkOQ39vkTDbX5k7LtsugFejv1mo5AcwVhC8TChSjWTPdxXCR5YjoF
 VgF0q1SG+KLg09uI3loyvA9Nei9qofCIzDSSDQnIsGEMUqqPWwUtzyOc91l7vcVgx79G
 bBUw==
X-Gm-Message-State: AFq9FYK3/RCxLApcULWGxjFjwDIq8OuipWfby24ApzIoyTsOTYmDXK6/
 hJdBUT304lsBNePRioPYbmWVphUpi1alemme1QbHeO+Vj8CMZOI9f6NfB0oY+22TYixKR3/CPh7
 RdDfTJaW3Xw7Kkjwo7cAGZ7tpE2/dVrmPjuDmGpry1BMrIDuuITSEY747Jg==
X-Gm-Gg: AYBFou1kfpK2ptn0kQ6fBXMs2hsqdseWVj2PvF4KaLZENQZGZ4VqLwhi7rUCxV4Rqg1
 DDi41bhR0A6NBi80iw+36B31GZwTJMA8Qo3T5Ifu6zizbbUD74kwiG1VSQKUB8VJwphmKGSssYB
 LQdMynuz697S73W9qfeoDjKN9HQE3qxzm+6SUuBhvt337pJEu6lDkYx++EC99fftMgezSDbc/OI
 3zni1jHzTAi2aSsIXuCfKiDL4ap9VoW9AZg/6zX5oOh1vM65sx0WY96dby27jOLfjCn70XaNgOu
 pfrcM09OBhplmvqccD61Oj945e5Ft21qHXjAu3dWCfPHYLDaUDMPmM4Z96tzssSql++aQC7MMRR
 GSY2YB08GmgyWaQSDeO7bgNCZTupowNbEWn+Moc2EnWVEq2t1ihDFYzSkUK3ebZwPl0pdEg==
X-Received: by 2002:a05:7300:51ec:b0:351:7c72:a8b with SMTP id
 5a478bee46e88-3517c720eeamr3280351eec.13.1791475282887; 
 Thu, 08 Oct 2026 09:01:22 -0700 (PDT)
X-Received: by 2002:a05:7300:51ec:b0:351:7c72:a8b with SMTP id
 5a478bee46e88-3517c720eeamr3280260eec.13.1791475281880; 
 Thu, 08 Oct 2026 09:01:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515b02d552sm30047307eec.28.2026.10.08.09.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 09:01:21 -0700 (PDT)
Message-ID: <98644e74-9219-42f0-bcf7-8cd7f02353af@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 09:01:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
 <asdkF80SJzF2W3sD@redhat.com>
 <CAE2XoE-Vc+CaE-3FerW3eXtTgspwxZJ6ZT0CZyg3ZYpoJ8xYXw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-Vc+CaE-3FerW3eXtTgspwxZJ6ZT0CZyg3ZYpoJ8xYXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac7be54 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=v0Zkhkck_tOZKS5kyTIA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: rV26_KncchNtr33N93jcOFsPXQ6Kf_Tk
X-Proofpoint-ORIG-GUID: rV26_KncchNtr33N93jcOFsPXQ6Kf_Tk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MyBTYWx0ZWRfX8hZYPqZ7HHVy
 7HWa915xqB/Gc1Qh9k3/ZzuJTkcFQwlF9gNa5D8xO3pX74kYsSdkkjMzhcWBb3QcGu6PI3H7+T3
 NobDkojC5lL49DqljvQDrs5qcQ/K+Bg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MyBTYWx0ZWRfX+eC11LkcHBLO
 qPLvxPsqR58JzlI4TDdqRSkLkjF29940xLL+WfzXNcsQonySt0UiM/zxvn5N2jItALB24EKUS/t
 6aJevD5vvdGZgobkLbBTI/tptWbzym3yRHgSgZ/11ynDQksF+EVqP8GY7P0HDuafa/jcajR9sxu
 5WKLf2vXKFMrNgR7XixLBzE16NE6KtiLJphibmC7y7XKWb6gRNeB6wLItc2BlZX0RgPRU53dr57
 QZ7MocIzQgkTfdsng24nbwntYPXsMw+yWFrASmBKboa8HlSIQgNW0intpFHJMDiAOTXL2s3VzWc
 zp3D50ZW5vu5+op51arHeX4fxan9k04gF5Z6cUB1Z51V5SecaSdwfzQ3tzd4qh4d3kY5hLCrjyQ
 aQTTezZvIYEWvxQm8dGn0bza5b5l6MQEBbVREkTgbZzI2TLNnY2Oc5Vv8FQniV8GlAx/0PG3Ymr
 1G3AMp7wu18h8go8/sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/8/2026 2:56 AM, Yonggang Luo wrote:
>>> How about letting machines (and machines only first), have a new field
>>> 'targets', being a uint32_t mask with an array of EMU_TARGET?
>>> machine->targets = EMU_TARGET_X | EMU_TARGET_Y;
> 
> To be explicit state what, I give you a pseudo code to compute
> machine->targets from TypeInfo::is_available(TargetInfo*)
> let targets=0
> foreach ti of TargetInfo list:
>    if (machine::TypeImpl::is_avaible(ti))
>          targets |= 1 << ti->target_arch
>    fi
> endif
> So they basically have equivalent effect, and is_available will handle
> other code-needed condition properly such as
> CPU/AccelClass. not restrict to targets, we can also attach the
> KConfig into TargetInfo, so is_available(TargetInfo*)
> also works for Kconfig. that's why I insist this way, it's solved all
> the issues around.
> 
> so  machine->targets = EMU_TARGET_X | EMU_TARGET_Y; is a good idea,
> and it can be implemented with TypeInfo::is_available(TargetInfo*)
> without much burden. and targets can be saved into a (machine or
> TypeImpl) for fast access when needed, we can compute it
> when the program starts.
>

In what we described, there is no need to keep any kind of callback,
targets field is sufficient to filter any type declaratively.

For the KConfig related types, I would really be keen to leave that
available for now, and add a proper error message later.

Regards,
Pierrick

