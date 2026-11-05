Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B9606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LyJSaVy1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i/iTFMGF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3RN-0006Vm-Fi; Thu, 05 Nov 2026 14:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xP3RM-0006Ve-18
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:48:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xP3RJ-0001UR-Te
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:48:03 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JL5gh751618
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 19:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qyOfft6IjcB8WWRiKKX20+
 8QgbQjFeymdmBiu6DQn6E=; b=LyJSaVy1WHjiS2Ee0Mi68THekS/UZNzMcfeMEF
 O8CvBi/UeN03neJaOJsDNIbazgAyw62UMc0J7N7zroJo5jKfhFsmWTBhW25yCxmK
 gYutgKISnICuB5sDPbyFnGZ5TPYIWb8MEcz1pdiW/n0cjJcwa++QxzLOGqC9ZnRL
 SpbxwtSmtFHvyChSze7ez5lcaG0wILy6Zefz3soV3qwG3qCq/e2aZONalO/wntzK
 U8SpoS4pmltCcKxVXQNSgsYlQbxCf8vs5xpckhjf6dO+R7hYMWG4cC27ImPdO/eZ
 pLu8Hc0DiZdAZy+P52eNUtXDSXNjyEHLVM17wfgDXcLhGznQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryvp83a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:47:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-536347602faso44814051cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793908079; x=1794512879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qyOfft6IjcB8WWRiKKX20+8QgbQjFeymdmBiu6DQn6E=;
 b=i/iTFMGFS4B326HV6rh5f7NyfUsSTl9dTBDdnUiPvX+AMyfsTpQHxmqup+tahFUEP8
 K99Ya9TVgCKjzTkorQSDXZqAPYE8IPx/tGgQG172Z3KhKJZPy9BBq8QPMIU3YvMu1UuN
 YVtqd3TcZuTzU/OqkKfl3dAsRB8g/8fb4+mhHpnHoV7lbgv5AkivfXQjl/JlH+d91ABx
 Eyo+k+vs76pohWW38Rh2iCrkzWGdjjzPaSUVqDFbZdAACdwsA1l04XPlLiL6MUE8yo9w
 AO8J4FvkkvHIW4SGvXdm4GOmeXmkenh9a3+17fxqk3qM/du9CVWxlEC6/WtBSOgX1pK0
 uhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908079; x=1794512879;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qyOfft6IjcB8WWRiKKX20+8QgbQjFeymdmBiu6DQn6E=;
 b=QfE6NHk9SvXuzvHurtBdHDBnVY+0+GK70VVVEgzH2f3JqnJC5cxTM9BFVmId6zH2nU
 /mgoTibbMCjvpkKtCpIT+JF0pBrJiV+k2M8r0utEzGv8J3hQxgCzIMLCVDypZJ0c9N4S
 qRYbgsRoS/qNIuVINJUhenrg+gSQfuyjabZDt+BaTwz/dLonPifwDq4haPNaSOGlY9k4
 0sXQTrVobKL4iC20hvfLtIZdejjsafXvdntjm0mO3YTuADbH2AmCWt5aD88c1h29CTgX
 xIwcKjNvMVDpCYaQbBdzrYX7hqrc6Xk+z/iJyGE1x0wdTnQjLBe9eRnZ+pPCsnc96nL5
 KH0A==
X-Gm-Message-State: APuU4Z9As4yLkelCct1N4HKWdCO9gsTxreSgoKo+TSVDSKqIcSRxCfRe
 XCofyWfEUGAmu2XnGKKWaOZwtd6rzy3URa3H24bCX2CrA3lwrDGC7QzceS0cbYZe8qEvEtVt38x
 VHWOnZVXO6599IpFWqFPehEbpmsl3waLflQHHWybzelYwZmBPRlkUoH2LRg==
X-Gm-Gg: AYBFou0dECWId9i1dyNp3vJZW6/MDynaAIg7ofm16q1ms/JZ5kBL56PnaMJvNga4TD+
 9k+lW/rZdLKY1o2p4U8ua2XZDfIIfbZ061lwdItiKnebhXoq0/7p/L4qHm/+7jmSS82W0Tp1Ty1
 QhOVSSJ01mQoOH4NpobqH7vlw+IMVkleMrmDr0S4nKZgs7Q/uOf0GQyps14dTYBo4QbqcNgzF/F
 wY/KbFUySZztNFJvqfJHXVGGfy7eis22OxhWkjRBanDbGh0GSwzPegC3cvAVW17eXB6Yaoy5x8S
 Fmh49nSBJ/5O7GIytAosNtzRISSGc0v/WdfLtSMZm+V6vz+5FxiOFTk5t6aAfB1uQ47AIvNQcpU
 EjZcIQiILbfkvBKHIpGQiJN6V9Kl6ZA5irNJSuxXSvqDdKLgW/1vBrgmPZR59MTwnlJ51E5KWq4
 t00tArImw8n/QwNZMlVUbDyUmkwti2oJRQuTjb
X-Received: by 2002:a05:622a:1e10:b0:536:582f:5dc9 with SMTP id
 d75a77b69052e-54e13888edcmr5971911cf.28.1793908078857; 
 Thu, 05 Nov 2026 11:47:58 -0800 (PST)
X-Received: by 2002:a05:622a:1e10:b0:536:582f:5dc9 with SMTP id
 d75a77b69052e-54e13888edcmr5971471cf.28.1793908078109; 
 Thu, 05 Nov 2026 11:47:58 -0800 (PST)
Received: from [10.222.169.242] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e2625abafsm1285361cf.16.2026.11.05.11.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:47:57 -0800 (PST)
Message-ID: <5059a259-f66a-47fc-b42b-b8118730e469@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 13:47:56 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: new roms/ mirror request: hexagonMVM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ib4Symqa c=1 sm=1 tr=0 ts=6aecdd6f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=9SuOsYX-VtA-xBQmUWYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: yzBvEH9U6o8pvmSJMPu_DQsLlnLBCQGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfX01/zUImfoyso
 AH1kpaJet4blMPIdRe9vlhPVDjveXAncimOxG+hYxJcGEeBVq9Aq+D29UXrtu7zRf51UZfYEbKk
 qpVsRbeLsEvhMg32+UAeHFcGZ2mJMW+0eUZoLl/faUq94nvI+Ms0cpnpbEXQBO+gXeQXYWewY2w
 YLKRqkTYFaNYuCHGJrPqkp1eH3qcCcO3/YusJxhlWzaU+oGJ3RsGZ6ZX9zM1S/DuHIg+0peP7Sz
 uT3RQq/or578z2+vy9tRntJVpvogT/d0KOLwz847WWa3D53q/Zu/uUiXNWZ9HW9UgImxfnHS1UM
 LO/p8BOqewsV+1zxEdD/1VzshCHUzvgrcGMAptiXqDvrnGyj9N/+Qigxedp6bhd2SwdPKz3aiWl
 IU3l7cKSLV99QYRbvvHemDJ1bBLE4ZSylgHrL5ZAcxleNiPJWrhzku59NRn5lZ7D1+T3nddsCjl
 iBFDPkOmtI88Atgo2iw==
X-Proofpoint-ORIG-GUID: yzBvEH9U6o8pvmSJMPu_DQsLlnLBCQGL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfX85QwExAoMnRY
 y4rylOKAz6aB0hy41xhcKE+q783UOU6gsa1DAi4/eOlysGOEFRm+Yu5yDoBow8NvkbmW9yLJqeB
 T6frkSrnzH8CQrzlHVhsXEHB3PczUDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stefan,


Could you also create a mirror for the "minivm" hypervisor repo "main" 
branch, similar to what was done for hexagon-hypervisor?


https://github.com/qualcomm/hexagonMVM.git


-Brian


